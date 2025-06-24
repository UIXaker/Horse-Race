import SwiftUI

@Observable
@MainActor
final class RacesModel {
    var horses: [Horse]
    var isRunning = false

    private let history: RaceHistoryStore
    private var raceStart: Date?
    private var raceTask: Task<Void, Never>?

    init(history: RaceHistoryStore) {
        self.history = history
        self.horses = (0..<5).map { index in
            Horse(
                id: index,
                color: Color(hue: Double(index)/5, saturation: 0.8, brightness: 0.9)
            )
        }
    }

    func start() {
        guard !isRunning else { return }
        
        isRunning = true
        raceStart = Date()
        raceTask = Task { await raceLoop() }
    }

    func restart() {
        raceTask?.cancel()
        raceTask = nil
        isRunning = false
        raceStart = nil
        
        for idx in horses.indices {
            horses[idx].progress = 0
            horses[idx].speed = Double.random(in: 0.004...0.006)
        }
    }

    private func raceLoop() async {
        while !Task.isCancelled && isRunning {
            for index in horses.indices where horses[index].progress < 1 {
                let variation = Double.random(in: 0.9...1.1)
                horses[index].progress += horses[index].speed * variation
                
                if horses[index].progress > 1 {
                    horses[index].progress = 1
                }
            }
            
            if horses.allSatisfy({ $0.progress >= 1 }) {
                finishRace()
                break
            }
            
            try? await Task.sleep(for: .milliseconds(16))
        }
    }

    private func finishRace() {
        isRunning = false
        raceTask?.cancel()
        raceTask = nil
        
        guard let start = raceStart else { return }
        let placements = horses.sorted { $0.progress > $1.progress }.map { $0.id }
        
        let result = RaceResult(
            date: Date(),
            winnerIndex: placements.first ?? 0,
            duration: Date().timeIntervalSince(start),
            placements: placements
        )
        
        history.results.insert(result, at: 0)
    }
}
