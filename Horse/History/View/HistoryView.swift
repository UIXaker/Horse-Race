import SwiftUI

struct HistoryView: View {
    @Environment(RaceHistoryStore.self) private var history

    var body: some View {
        NavigationStack {
            HistoryList(results: history.results)
                .navigationTitle("История")
        }
    }
}

private struct HistoryList: View {
    let results: [RaceResult]
    @State private var expanded: Set<RaceResult.ID> = []

    var body: some View {
        List(results) { result in
            DisclosureGroup(
                isExpanded: Binding(
                    get: { expanded.contains(result.id) },
                    set: { isExpanded in
                        if isExpanded { expanded.insert(result.id) } else { expanded.remove(result.id) }
                    }
                )
            ) {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(result.results) { placement in
                        Text("\(placement.place). \(placement.name) — " + String(format: "%.2f c", placement.time))
                    }
                }
                .padding(.top, 4)
            } label: {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Заезд от \(result.date.formatted(date: .numeric, time: .shortened))")
                        .font(.headline)
                    Text("Победитель: \(result.winnerName)")
                    Text(String(format: "Время: %.2f сек.", result.duration))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
