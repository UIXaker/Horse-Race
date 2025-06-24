import SwiftUI

struct RacesView: View {
    @Bindable var model: RacesModel
    
    var body: some View {
        VStack {
            Text("Дистанция: \(Int(model.trackLength)) м")
                .font(.headline)
            
            GeometryReader { geo in
                VStack(spacing: 12) {
                    ForEach(model.horses) { horse in
                        HorseRow(horse: horse,
                                 trackWidth: geo.size.width,
                                 trackLength: model.trackLength,
                                 tickDuration: model.tickDuration)
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .frame(height: 260)
            
            HStack(spacing: 24) {
                Button("Старт", action: model.start)
                    .buttonStyle(.borderedProminent)
                    .disabled(model.isRunning)
                
                Button("Рестарт", action: model.restart)
                    .buttonStyle(.bordered)
            }
            .font(.title3)
            .padding(.top, 24)
        }
        .padding()
        .animation(.smooth(duration: 1/60), value: model.horses)
    }
}
