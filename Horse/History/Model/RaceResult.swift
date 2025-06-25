import SwiftUI

struct HorsePlacement: Identifiable, Hashable, Equatable, Codable {
    var id = UUID()
    let place: Int
    let name: String
    let time: TimeInterval
}

struct RaceResult: Identifiable, Equatable, Codable {
    var id = UUID()
    let date: Date
    let duration: TimeInterval
    let length: Double
    let placements: [HorsePlacement]
    
    var winnerName: String { placements.first?.name ?? "" }
    var winnerTime: TimeInterval { placements.first?.time ?? 0 }
}
