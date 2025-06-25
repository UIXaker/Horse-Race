import SwiftUI

struct HistoryView: View {
    @Environment(RaceHistoryStore.self) private var history
    @State private var showClearAlert = false
    
    var body: some View {
        NavigationStack {
            HistoryList(results: history.results)
                .navigationTitle("История")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            NotificationManager.requestPushAuthorization()
                        } label: {
                            Image(systemName: "bell.badge")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showClearAlert = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                }
                .alert("Очистить историю?", isPresented: $showClearAlert) {
                    Button("Удалить", role: .destructive) { history.clear() }
                    Button("Отмена", role: .cancel) { }
                }
        }
    }
}

private struct HistoryList: View {
    let results: [RaceResult]
    @State private var expanded: Set<RaceResult.ID> = []
    
    var body: some View {
        VStack(spacing: 18) {
            ForEach(results.indices.reversed(), id: \.self) { index in
                let result = results[index]
                
                VStack(spacing: 4) {
                    HStack {
                        Text("Заезд #\(index + 1)")
                        Spacer()
                        Text(result.date.formatted(date: .numeric, time: .shortened))
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 6)
                    
                    HistoryRow(result: result, isExpanded: expanded.contains(result.id))
                        .onTapGesture {
                            if expanded.contains(result.id) {
                                expanded.remove(result.id)
                            } else {
                                expanded.insert(result.id)
                            }
                        }
                }
                .padding(.horizontal, 12)
            }
            
            Color.clear
        }
        .animation(.smooth(duration: 0.3), value: expanded)
        .animation(.smooth(duration: 0.3), value: results)
        .overlay {
            if results.isEmpty {
                ContentUnavailableView(
                    "Заезды еще не проводились",
                    systemImage: "figure.equestrian.sports.circle",
                    description: Text("Тут появятся результаты заездов после их проведения")
                )
            }
        }
        .background(Color(.secondarySystemBackground))
    }
}
