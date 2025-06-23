import SwiftUI

enum Tabs: CaseIterable {
        case home, history
        
        var item: TabItem {
            switch self {
            case .home:
                    .init(
                        title: "Race",
                        systemImage: "figure.equestrian.sports",
                        color: .blue
                    )
                
            case .history:
                    .init(
                        title: "Discover",
                        systemImage: "clock",
                        color: .green
                    )
            }
        }
    }
