import SwiftUI

struct HiddenPiPView: UIViewRepresentable {
    let manager: PictureInPicturePlayer
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        manager.playerLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        view.layer.addSublayer(manager.playerLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
