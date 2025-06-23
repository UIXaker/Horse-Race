import SwiftUI

struct HorseRow: View {
    let horse: Horse
    let trackWidth: CGFloat

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.15))
                .frame(height: 12)
            
            Image(systemName: "figure.equestrian.sports")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .foregroundColor(horse.color)
                .offset(x: CGFloat(horse.progress) * (trackWidth - 36))
        }
    }
}
