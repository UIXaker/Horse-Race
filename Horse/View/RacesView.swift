import SwiftUI

struct RacesView: View {
    @Bindable var model: RacesModel
    
    var body: some View {
        VStack {
            Picker("Дистанция", selection: $model.trackLength) {
                Text("250 м").tag(250.0)
                Text("500 м").tag(500.0)
                Text("1000 м").tag(1000.0)
            }
            .pickerStyle(.segmented)
            .disabled(model.isRunning)

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
