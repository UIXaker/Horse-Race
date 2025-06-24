import SwiftUI

struct HorseRow: View {
    let horse: Horse
    let isExpanded: Bool
    
    @State private var trackWidth: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.15))
                .frame(height: 12)
                .opacity(isExpanded ? 1 : 0)
            
            Image(systemName: "figure.equestrian.sports")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .foregroundColor(horse.color)
                .offset(x: CGFloat(horse.progress) * (trackWidth - 36))
        }
        .readSize { size in
            trackWidth = size.width
        }
    }
}

import SwiftUI

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
