import SwiftUI
import Kingfisher

struct LeaderboardView: View {
    let sortedHorses: [Horse]
    let isRunning: Bool
    
    @State private var showLive = false
    @State private var winnerWidth: CGFloat = 0
    @State private var speedWidth: CGFloat = 0
        
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ZStack(alignment: .top) {
                if sortedHorses.first?.progress ?? 0 >= 1 {
                    let path = Bundle.main.url(forResource: "Finish", withExtension: "gif")!
                    let finishGifResource = LocalFileImageDataProvider(fileURL: path)
                    
                    KFAnimatedImage(resource: finishGifResource)
                        .scaledToFit()
                        .frame(width: winnerWidth, height: 36 + 12)
                        .clipShape(.rect(cornerRadius: 12))
                }
                
                HStack(alignment: .top, spacing: 16) {
                    let sortedHorses = sortedHorses
                    let firstFinished = sortedHorses.first?.progress ?? 0 >= 1

                    if speedWidth < 1 {
                        Text("108 км/ч")
                            .font(.caption)
                            .lineLimit(1)
                            .readSize { speedWidth = $0.width }
                            .hidden()
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(sortedHorses.indices, id: \.self) { index in
                            Text("#\(index + 1)")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(firstFinished && index == 0 ? .white : .primary)
                                .frame(height: 36)
                        }
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(sortedHorses) { horse in
                            HStack(spacing: 12) {
                                Image(systemName: "figure.equestrian.sports")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(horse.color)
                                
                                let isWinner = horse.progress >= 1 && horse == sortedHorses.first
                                Text(horse.name)
                                    .font(.body.weight(.medium))
                                    .foregroundStyle(isWinner ? .white : .primary)
                                    .lineLimit(1)
                                
                                let speed = Int(horse.speed * 3.6)
                                Text("\(speed) км/ч")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                                    .frame(width: speedWidth, alignment: .leading)
                            }
                            .geometryGroup()
                        }
                    }
                }
                .padding(12)
                .background(.primary.opacity(0.1))
                .clipShape(.rect(cornerRadius: 12))
                .readSize { winnerWidth = $0.width }
            }
            
            Spacer()
            
            if isRunning {
                Button {
                    showLive.toggle()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "record.circle")
                            .font(.footnote)
                            .symbolEffect(.pulse.byLayer)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.red)
                        
                        Text("Live")
                            .font(.body)
                            .foregroundStyle(.red)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 8))
                }
                .padding(.top, -6)
                .transition(.opacity)
            }
        }
        .padding(.horizontal)
        .geometryGroup()
    }
}
