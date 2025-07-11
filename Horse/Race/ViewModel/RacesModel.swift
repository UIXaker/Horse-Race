import Observation
import SwiftUI
import Kingfisher

@Observable
final class RacesModel {
    var horses: [Horse]
    var isRunning = false
    let trackLengthOptions: [Double] = [50, 250, 500, 1000]
    var trackLength: Double = 50
    var latestResult: RaceResult?

    var sortedHorses: [Horse] {
        let finished = horses
            .filter { finishTimes[$0.id] != nil }
            .sorted { (finishTimes[$0.id] ?? 0) < (finishTimes[$1.id] ?? 0) }

        let unfinished = horses
            .filter { finishTimes[$0.id] == nil }
            .sorted { $0.progress > $1.progress }

        return finished + unfinished
    }
    
    private let tickDuration: TimeInterval = 0.016
    private var finishTimes: [Int: TimeInterval] = [:]
    
    private let history: RaceHistoryStore
    private var raceStart: Date?
    private var raceTask: Task<Void, Never>?
    
    init(history: RaceHistoryStore) {
        self.history = history
        
        let defaultNames = ["Буян", "Пегас", "Ветер", "Гром", "Яков"]
        let defaultColors: [Color] = [.cyan, .indigo, .orange, .green, .pink]
        
        horses = (0..<5).map { index in
            Horse(
                id: index,
                name: defaultNames[index],
                color: defaultColors[index]
            )
        }
    }
    
    func start() {
        guard !isRunning else { return }
        
        restart()
        isRunning = true
        raceStart = Date()
        raceTask = Task { await raceLoop() }
    }
    
    func restart() {
        raceTask?.cancel()
        raceTask = nil
        raceStart = nil
        isRunning = false
        latestResult = nil
        finishTimes.removeAll()
        
        for idx in horses.indices {
            horses[idx].progress = 0
            horses[idx].speed = .random(in: 12...25)
        }
    }
    
    private func raceLoop() async {
        while !Task.isCancelled && isRunning {
            for index in horses.indices where horses[index].progress < 1 {
                let delta = Double.random(in: -1...1)
                horses[index].speed = min(max(12, horses[index].speed + delta), 30)
                horses[index].progress += horses[index].speed * tickDuration / trackLength
                
                if horses[index].progress > 1 {
                    horses[index].progress = 1
                    if finishTimes[horses[index].id] == nil, let raceStart {
                        finishTimes[horses[index].id] = Date().timeIntervalSince(raceStart)
                    }
                }
            }
            
            if finishTimes.count == horses.count {
                finishRace()
                break
            }
            
            try? await Task.sleep(for: .seconds(tickDuration))
        }
    }
    
    private func finishRace() {
        isRunning = false
        raceTask?.cancel()
        raceTask = nil
        
        guard raceStart != nil else { return }
        
        let ordered = finishTimes.sorted { $0.value < $1.value }
        let placements: [HorsePlacement] = ordered.enumerated().compactMap { index, pair in
            guard let horse = horses.first(where: { $0.id == pair.key }) else { return nil }
            return HorsePlacement(place: index + 1, name: horse.name, time: pair.value)
        }
        
        let result = RaceResult(
            date: Date(),
            duration: finishTimes.values.max() ?? 0,
            length: trackLength,
            placements: placements
        )

        history.results.append(result)
        latestResult = result
        Task { await APIClient.send(result: result) }
    }
}
