import SwiftUI

struct RaceTrackView: View {
    @Binding var isExpanded: Bool
    let horses: [Horse]

    var body: some View {
        let layout = isExpanded
        ? AnyLayout(VStackLayout(spacing: 12))
        : AnyLayout(ZStackLayout())
        
        ZStack(alignment: .topLeading) {
            layout {
                ForEach(horses) { horse in
                    let isFirst = horse == horses.first
                    
                    HorseRow(
                        horse: horse,
                        isExpanded: isFirst || isExpanded
                    )
                }
            }
            .padding(12)
            .background(.white)
            .clipShape(.rect(cornerRadius: 12))
            .padding()
            
            Image(systemName: isExpanded ? "arrow.up.right.and.arrow.down.left" : "arrow.down.backward.and.arrow.up.forward")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundStyle(.primary)
                .padding(6)
                .background(.blue.gradient.opacity(0.2))
                .clipShape(.circle)
                .padding(6)
        }
        .onTapGesture { isExpanded.toggle() }
    }
}
