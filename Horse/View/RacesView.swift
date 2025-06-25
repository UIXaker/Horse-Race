import SwiftUI
import AVKit
import Kingfisher

struct RacesView: View {
    @Bindable var model: RacesModel
    @State private var isExpanded: Bool = false
    @State private var showLive: Bool = false
    @State private var winnerWidth: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
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
            
            HStack(alignment: .top, spacing: 0) {
                ZStack(alignment: .top) {
                    if let firstHorse = model.horses.sorted(by: { $0.progress > $1.progress }).first, firstHorse.progress >= 1 {
                        KFAnimatedImage(resource: model.resource)
                            .scaledToFit()
                            .frame(width: winnerWidth, height: 36 + 12)
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    
                    HStack(alignment: .top, spacing: 16) {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(model.horses.indices, id: \.self) { index in
                                Text("#\(index + 1)")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.primary)
                                    .frame(height: 36)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            let sortedHorses = model.horses.sorted { $0.progress > $1.progress }
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
                
                if model.isRunning {
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

struct KFAnimatedImage: UIViewRepresentable {
    var resource: ImageDataProvider?

    func makeUIView(context: Context) -> AnimatedImageView {
        let view = AnimatedImageView()
        view.contentMode = .scaleAspectFit
        return view
    }
    
    func updateUIView(_ uiView: AnimatedImageView, context: Context) {
        uiView.kf.setImage(with: resource)
    }
    
}
