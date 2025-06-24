import SwiftUI

struct RacesView: View {
    @Bindable var model: RacesModel
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(spacing: 6) {
            Text("Дистанция: \(Int(model.trackLength)) м")
                .font(.title)
                .bold()
            
            let layout = isExpanded
            ? AnyLayout(VStackLayout(spacing: 12))
            : AnyLayout(ZStackLayout())
            
            ZStack(alignment: .topLeading) {
                layout {
                    ForEach(model.horses) { horse in
                        let isFirst = horse == model.horses.first
                        
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
            .onTapGesture {
                isExpanded.toggle()
            }
            
            
            
            
            Spacer()
            
            Picker("Дистанция", selection: $model.trackLength) {
                ForEach(model.trackLengthOptions, id: \.self) { option in
                    Text("\(Int(option)) м").tag(option)
                }
            }
            .pickerStyle(.menu)
            .disabled(model.isRunning)
            .padding(.horizontal, 12)
            
            Button(action: model.isRunning ? model.restart : model.start) {
                Text(model.isRunning ? "Рестарт" : "Старт")
                    .foregroundStyle(model.isRunning ? .blue : .green)
            }
            .buttonStyle(
                NiceButtonStyle(
                    color: model.isRunning ? .blue.opacity(0.1) : .green.opacity(0.1),
                    strokeWidth: 4,
                    strokeColor: model.isRunning ? .blue.opacity(0.3) : .green.opacity(0.3)
                )
            )
            .padding(.horizontal, 12)
        }
        .animation(.smooth, value: model.horses)
        .animation(.smooth, value: isExpanded)
        .background(Color(.secondarySystemBackground))
    }
}
