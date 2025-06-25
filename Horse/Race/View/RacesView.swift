import SwiftUI
import AVKit
import Kingfisher

struct RacesView: View {
    @Bindable var model: RacesModel
    @State private var isExpanded: Bool = false
    @State private var showLive: Bool = false
    @State private var winnerWidth: CGFloat = 0
    @State private var speedWidth: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Дистанция: \(Int(model.trackLength)) м")
                .font(.title)
                .bold()
            
            RaceTrackView(
                isExpanded: $isExpanded,
                horses: model.horses
            )
            
            LeaderboardView(
                sortedHorses: model.sortedHorses,
                isRunning: model.isRunning
            )
            
            Spacer()
            
            RaceControls(
                trackLength: $model.trackLength,
                trackLengthOptions: model.trackLengthOptions,
                isRunning: model.isRunning,
                restartAction: model.restart,
                startAction: model.start
            )
            .padding(.horizontal, 12)
        }
        .animation(.smooth, value: model.horses)
        .animation(.smooth, value: isExpanded)
        .background(Color(.secondarySystemBackground))
    }
}
