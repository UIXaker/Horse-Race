import SwiftUI

struct RaceControls: View {
    @Binding var trackLength: Double
    let trackLengthOptions: [Double]
    let isRunning: Bool
    
    let restartAction: () -> Void
    let startAction: () -> Void
    
    var body: some View {
        Picker("Дистанция", selection: $trackLength) {
            ForEach(trackLengthOptions, id: \.self) { option in
                Text("\(Int(option)) м").tag(option)
            }
        }
        .pickerStyle(.menu)
        .disabled(isRunning)
        
        Button(action: isRunning ? restartAction : startAction) {
            Text(isRunning ? "Рестарт" : "Старт")
                .foregroundStyle(isRunning ? .blue : .green)
        }
        .buttonStyle(
            NiceButtonStyle(
                color: isRunning ? .blue.opacity(0.1) : .green.opacity(0.1),
                strokeWidth: 4,
                strokeColor: isRunning ? .blue.opacity(0.3) : .green.opacity(0.3)
            )
        )
    }
}
