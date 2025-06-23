import SwiftUI

// MARK: – Persistence (UserDefaults + Codable)
@Observable
final class RaceHistoryStore {
    var results: [RaceResult] = [] {
        didSet { save() }
    }
    private let key = "race_history"

    init() { load() }

    // ––––– private helpers ––––– //
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([RaceResult].self, from: data) else { return }
        results = decoded
    }
    private func save() {
        guard let data = try? JSONEncoder().encode(results) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
