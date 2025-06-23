import SwiftUI

struct Horse: Identifiable, Equatable {
    let id: Int
    let color: Color
    var progress: Double = 0
}
