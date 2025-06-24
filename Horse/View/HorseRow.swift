import SwiftUI

struct HorseRow: View {
    let horse: Horse
    let trackWidth: CGFloat
    let trackLength: Double
    let tickDuration: TimeInterval
    
    private var speedKMH: Double {
        horse.speed * 3.6
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(horse.name)
                .font(.headline)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: 12)
                
                VStack {
                    Image(systemName: "figure.equestrian.sports")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .foregroundColor(horse.color)
                    
                    Text(String(format: "%.0f км/ч", speedKMH))
                        .font(.caption2)
                        .frame(width: 60)
                        .foregroundStyle(.secondary)
                }
                .offset(x: CGFloat(horse.progress) * (trackWidth - 36))
            }
        }
    }
}
