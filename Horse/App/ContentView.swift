import SwiftUI

struct ContentView: View {
    @State private var historyStore: RaceHistoryStore
    @State private var raceModel: RacesModel
    
    init() {
        let historyStore = RaceHistoryStore()
        let raceModel = RacesModel(history: historyStore)
        
        self.historyStore = historyStore
        self.raceModel = raceModel
    }
    
    var body: some View {
        WithTabBar { tabs in
            switch tabs {
            case .home:
                RacesView()
                
            case .history:
                HistoryView()
            }
        }
        .environment(raceModel)
        .environment(historyStore)
    }
}

#Preview {
    ContentView()
}
