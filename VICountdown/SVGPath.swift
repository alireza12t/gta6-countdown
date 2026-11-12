import SwiftUI

// Paste any SVG path string, get a SwiftUI Path.
// Handles M L H V C S Q Z, upper case (absolute) and lower case (relative).
extension Path {
    init(svg d: String) {
        self.init()
        let tokens = d.matches(of: /-?\d*\.?\d+|[A-Za-z]/).map { String($0.output) }
        var i = 0
        var command: Character = "M"
        var current = CGPoint.zero, start = CGPoint.zero
        var lastControl: CGPoint?

        func number() -> CGFloat {
            defer { i += 1 }
            return i < tokens.count ? CGFloat(Double(tokens[i]) ?? 0) : 0
        }

        while i < tokens.count {
            if let letter = tokens[i].first, letter.isLetter {
                command = letter
                i += 1
                if letter == "Z" || letter == "z" {
                    closeSubpath()
                    current = start
                }
                continue
            }

            let relative = command.isLowercase
            func point() -> CGPoint {
                let x = number(), y = number()
                return relative ? CGPoint(x: current.x + x, y: current.y + y) : CGPoint(x: x, y: y)
            }
            var control: CGPoint?

            switch command.uppercased() {
            case "M":
                current = point()
                start = current
                move(to: current)
                command = relative ? "l" : "L"      // extra pairs after M are lines
            case "L":
                current = point()
                addLine(to: current)
            case "H":
                current.x = number() + (relative ? current.x : 0)
                addLine(to: current)
            case "V":
                current.y = number() + (relative ? current.y : 0)
                addLine(to: current)
            case "C":
                let c1 = point(), c2 = point(), end = point()
                addCurve(to: end, control1: c1, control2: c2)
                (control, current) = (c2, end)
            case "S":                               // smooth curve: mirror the last control point
                let mirror = lastControl ?? current
                let c1 = CGPoint(x: 2 * current.x - mirror.x, y: 2 * current.y - mirror.y)
                let c2 = point(), end = point()
                addCurve(to: end, control1: c1, control2: c2)
                (control, current) = (c2, end)
            case "Q":
                let c = point(), end = point()
                addQuadCurve(to: end, control: c)
                current = end
            default:
                i += 1
            }
            lastControl = control
        }
    }
}

// The same path as a Shape that scales itself to fit, like an image would.
// Because it's a Shape you get fill, stroke and trim for free.
struct SVGShape: Shape {
    let path: Path
    let viewBox: CGRect

    init(_ d: String, in viewBox: CGRect) {
        path = Path(svg: d)
        self.viewBox = viewBox
    }

    func path(in rect: CGRect) -> Path {
        let scale = min(rect.width / viewBox.width, rect.height / viewBox.height)
        let fit = CGAffineTransform(translationX: rect.midX, y: rect.midY)
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: -viewBox.midX, y: -viewBox.midY)
        return path.applying(fit)
    }
}

#Preview {
    SVGShape("M10 80 C 40 10, 65 10, 95 80 S 150 150, 180 80", in: CGRect(x: 0, y: 0, width: 190, height: 160))
        .stroke(.pink, lineWidth: 4)
        .padding(40)
}
