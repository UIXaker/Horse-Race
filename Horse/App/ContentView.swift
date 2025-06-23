import SwiftUI

struct ContentView: View {
    @State private var historyStore = RaceHistoryStore()
    
    var body: some View {
        WithTabBar { tabs in
            switch tabs {
            case .home:
                RacesView(model: RacesModel(history: historyStore))
                
            case .history:
                HistoryView(history: historyStore)
            }
        }
    }
}

#Preview {
    ContentView()
}
