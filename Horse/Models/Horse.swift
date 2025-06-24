import SwiftUI

struct Horse: Identifiable, Equatable {
    let id: Int
    let name: String
    let color: Color
    var speed: Double
    var progress: Double = 0
    
    init(id: Int, name: String, color: Color, speed: Double = .random(in: 14...25)) {
        self.id = id
        self.name = name
        self.color = color
        self.speed = speed
    }
}
