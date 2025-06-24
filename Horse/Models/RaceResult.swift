import SwiftUI

struct HorsePlacement: Identifiable, Codable {
    var id = UUID()
    let place: Int
    let name: String
    let time: TimeInterval
}

struct RaceResult: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let duration: TimeInterval
    let results: [HorsePlacement]
    
    var winnerName: String { results.first?.name ?? "" }
}
