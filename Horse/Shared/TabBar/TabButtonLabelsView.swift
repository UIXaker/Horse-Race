import SwiftUI

struct ActiveTabLabel: View {
    let tabItem: TabItem

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .fill(tabItem.color.opacity(0.1))
                .shadow(color: .primary.opacity(0.5), radius: 3, x: 0, y: 5)
                .frame(width: 120, height: 50)
            
            Label(tabItem.title, systemImage: tabItem.systemImage)
                .labelStyle(.titleAndIcon)
        }
    }
}

struct InActiveTabLabel: View {
    let tabItem: TabItem

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .fill(.clear)
                .frame(width: 50, height: 50)
            
            Label(tabItem.title, systemImage: tabItem.systemImage)
                .labelStyle(.iconOnly)
                .symbolEffectsRemoved()
        }
    }
}
