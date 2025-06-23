import SwiftUI

struct RaceResult: Identifiable, Codable {
    let id = UUID()
    let date: Date
    let winnerIndex: Int
    let duration: TimeInterval
    let placements: [Int]
}
