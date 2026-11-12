import SwiftUI

struct FlipCard: View {
    let text: String
    @State private var old: String
    @State private var top = 0.0
    @State private var bottom = 90.0

    init(_ text: String) {
        self.text = text
        _old = State(initialValue: text)
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                half(text, .top)
                half(old, .bottom)
            }
            VStack(spacing: 0) {
                half(old, .top)
                    .rotation3DEffect(.degrees(top),
                        axis: (1, 0, 0), anchor: .bottom,
                        perspective: 0.4)
                half(text, .bottom)
                    .rotation3DEffect(.degrees(bottom),
                        axis: (1, 0, 0), anchor: .top,
                        perspective: 0.4)
            }
            Color.black.frame(width: 78, height: 2)
        }
        .onChange(of: text) { before, _ in
            old = before
            withAnimation(.easeIn(duration: 0.22)) {
                top = -90
            }
            withAnimation(.easeOut(duration: 0.22)
                .delay(0.22)) {
                bottom = 0
            } completion: {
                // reset quietly, nothing moves
                withTransaction(.init(animation: nil)) {
                    old = text; top = 0; bottom = 90
                }
            }
        }
    }

    func half(_ s: String, _ edge: Alignment) -> some View {
        Text(s)
            .font(.system(size: 54, weight: .heavy))
            .foregroundStyle(.white)
            .frame(width: 78, height: 96)
            .background(ink, in: .rect(cornerRadius: 12))
            .frame(height: 48, alignment: edge)
            .clipped()
    }
}

#Preview {
    FlipCard("07")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
}
