import SwiftUI

struct WithTabBar<Content>: View where Content: View {
    @State private var selection: Tabs = .history
    @ViewBuilder var content: (Tabs) -> Content
    
    var body: some View {
        ZStack {
            Color.clear
            
            VStack {
                content(selection)
            }
        }
        .safeAreaInset(edge: .bottom) {
            TabBar(selection: $selection)
                .padding()
        }
    }
}

struct TabBar: View {
    @Binding var selection: Tabs
    @State private var symbolTrigger: Bool = true
    @Namespace private var tabItemNameSpace

    func changeTabTo(_ tab: Tabs) {
        withAnimation(.bouncy(duration: 0.3, extraBounce: 0.15)) {
            selection = tab
        }
        
        symbolTrigger.toggle()
    }

    var body: some View {
        HStack(spacing: 10) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                Button {
                    changeTabTo(tab)
                } label: {
                    if tab == selection {
                        ActiveTabLabel(tabItem: tab.item)
                            .matchedGeometryEffect(id: "tabItem", in: tabItemNameSpace)
                    } else {
                        InActiveTabLabel(tabItem: tab.item)
                    }
                }
                .symbolEffect(.bounce.up.byLayer, value: symbolTrigger)
                .foregroundStyle(tab.item.color)
                .buttonStyle(TabButtonStyle())
            }
        }
        .padding(10)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 35.0))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
    }
}

