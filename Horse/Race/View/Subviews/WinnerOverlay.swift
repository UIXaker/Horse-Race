import SwiftUI
import Kingfisher

struct WinnerOverlay: View {
    let winnerName: String
    @State private var showGif = false
    @State private var showName = false
    @State private var appear = false
    
    let disappear: () -> Void
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text("Winner")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(appear ? 1 : 0)
                    .scaleEffect(appear ? 1 : 0.8)
                
                if showName {
                    Text(winnerName)
                        .font(.system(size: 48, weight: .semibold))
                        .foregroundColor(.white)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                if showGif {
                    let path = Bundle.main.url(forResource: "Winner", withExtension: "gif")!
                    let resource = LocalFileImageDataProvider(fileURL: path)
                    
                    KFAnimatedImage(resource: resource)
                        .scaledToFit()
                        .ignoresSafeArea()
                        .transition(.blurReplace)
                }
            }
        }
        .opacity(appear ? 1 : 0)
        .onAppear {
            appear = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                showName = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showGif = true
            }
        }
        .animation(.easeOut(duration: 0.4), value: appear)
        .animation(.smooth(duration: 0.3), value: showName)
        .animation(.smooth(duration: 0.3), value: showGif)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                disappear()
            }
        }
    }
}
