import SwiftUI

struct ContentView: View {
    @State var progress = 0.0
    let release = Calendar.current.date(from:
        DateComponents(year: 2026, month: 11, day: 19))!

    var loaded: Bool { progress >= 1 }

    var body: some View {
        VStack(spacing: 44) {
            GTALogo(progress: progress)
                .scaleEffect(loaded ? 1 : 0.92)
                .shadow(color: loaded ? pink : .clear,
                        radius: 30)

            if loaded {
                VStack(spacing: 22) {
                    FlipClock(date: release)
                    Text("NOVEMBER 19, 2026")
                        .font(.footnote.bold())
                        .kerning(5)
                }
                .transition(.move(edge: .bottom)
                    .combined(with: .opacity))
            } else {
                Text("LOADING \(Int(progress * 100))%")
                    .font(.footnote.bold())
                    .monospacedDigit()
                    .kerning(3)
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            Text(disclaimer)
                .font(.caption2)
                .foregroundStyle(.gray)
        }
        .background(.black)
        .animation(.spring(duration: 0.7, bounce: 0.35),
                   value: loaded)
        .task {
            while progress < 1 {
                try? await Task.sleep(
                    for: .milliseconds(16))
                progress = min(1, progress + 0.005)
            }
        }
    }
}

#Preview {
    ContentView()
}
