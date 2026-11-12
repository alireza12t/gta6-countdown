import SwiftUI

// Days, hours, minutes and seconds until any date, on four flip cards.
struct FlipClock: View {
    let date: Date

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let left = max(0, Int(date.timeIntervalSince(context.date)))

            HStack(spacing: 10) {
                unit(left / 86_400, "DAYS")
                unit(left / 3_600 % 24, "HOURS")
                unit(left / 60 % 60, "MIN")
                unit(left % 60, "SEC")
            }
        }
    }

    func unit(_ value: Int, _ label: String) -> some View {
        VStack(spacing: 8) {
            FlipCard(String(format: "%02d", value))
            Text(label)
                .font(.caption2.bold())
                .kerning(2)
                .foregroundStyle(.white.opacity(0.6))
        }
    }
}

#Preview {
    FlipClock(date: .now.addingTimeInterval(100_000))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
}
