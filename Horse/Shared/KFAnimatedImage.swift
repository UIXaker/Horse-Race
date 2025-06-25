import SwiftUI
import Kingfisher

struct KFAnimatedImage: UIViewRepresentable {
    var resource: ImageDataProvider?

    func makeUIView(context: Context) -> AnimatedImageView {
        return AnimatedImageView()
    }
    
    func updateUIView(_ uiView: AnimatedImageView, context: Context) {
        uiView.kf.setImage(with: resource)
    }
    
}
