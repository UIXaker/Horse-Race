import Foundation
import SwiftUI

struct TabItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let systemImage: String
    let color: Color
}
