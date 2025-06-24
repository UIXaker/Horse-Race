import SwiftUI

struct Horse: Identifiable, Equatable {
    let id: Int
    let color: Color
    var progress: Double = 0
    var speed: Double

    init(id: Int, color: Color, speed: Double = Double.random(in: 0.004...0.006)) {
        self.id = id
        self.color = color
        self.progress = 0
        self.speed = speed
    }
}
