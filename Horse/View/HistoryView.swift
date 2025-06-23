import SwiftUI

struct HistoryView: View {
    @Bindable var history: RaceHistoryStore

    var body: some View {
        NavigationStack {
            List(history.results) { result in
                VStack(alignment: .leading, spacing: 4) {
                    Text("Заезд от \(result.date.formatted(date: .numeric, time: .shortened))")
                        .font(.headline)
                    Text("Победитель: Лошадь \(result.winnerIndex + 1)")
                    Text(String(format: "Время: %.2f сек.", result.duration))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("История")
        }
    }
}
