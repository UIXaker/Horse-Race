import SwiftUI
import AVKit
import Kingfisher

struct RacesView: View {
    @Environment(RacesModel.self) private var model
    @State private var isExpanded: Bool = false
    @State private var showLive: Bool = false
    @State private var winnerWidth: CGFloat = 0
    @State private var speedWidth: CGFloat = 0
    @State private var pipManager = PictureInPicturePlayer()
    
    var body: some View {
        @Bindable var model = model
        
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
                isRunning: model.isRunning,
                showLive: $showLive
            )
            
            HiddenPiPView(manager: pipManager)
            
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
        .animation(.smooth(duration: 0.3), value: model.horses)
        .animation(.smooth(duration: 0.3), value: isExpanded)
        .background(Color(.secondarySystemBackground))
        .overlay {
            if let result = model.latestResult {
                WinnerOverlay(winnerName: result.winnerName) {
                    model.latestResult = nil
                }
            }
        }
        .onChange(of: showLive) { oldValue, newValue in
            pipManager.toggle()
        }
        .onChange(of: model.isRunning) { oldValue, newValue in
            newValue ? pipManager.start() : pipManager.stop()
            
            if !newValue {
                showLive = false
            }
        }
    }
}
