import SwiftUI

struct GTALogo: View {
    var progress = 1.0

    var body: some View {
        let trace = min(progress * 2, 1)
        let fill = max(progress * 2 - 1, 0)

        ZStack {
            Group {
                vi.trim(from: 0, to: trace)
                    .stroke(pink, lineWidth: 2)
                words.trim(from: 0, to: trace)
                    .stroke(.white, lineWidth: 1.5)
            }
            .shadow(color: pink, radius: 6)
            .opacity(1 - fill)

            // colors: the logo's own hex values
            Group {
                vi.stroke(purple, lineWidth: 19)
                vi.fill(sunset)
                vi.stroke(gold, lineWidth: 6)
                words.stroke(pink, lineWidth: 10)
                words.stroke(ink, lineWidth: 8)
                words.fill(.white)
            }
            .mask {
                Rectangle().scaleEffect(
                    y: fill, anchor: .bottom)
            }
        }
        .frame(width: 340, height: 258)
    }

    let vi = SVGShape("""
        M368.8,730.2 L555,344.4 L699.2,45.8 H464.4
        L368.8,240.2 L273.1,45.8 H38.3 L182.5,344.4 Z
        M738.1,45.8 h234 v708.4 h-234 Z
        """, in: logoBox)
    let words = SVGShape(logoWords, in: logoBox)
}

#Preview {
    GTALogo()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
}
