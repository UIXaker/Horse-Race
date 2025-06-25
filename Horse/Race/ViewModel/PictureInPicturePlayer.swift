import SwiftUI
import AVKit

@Observable
@MainActor
final class PictureInPicturePlayer: NSObject, AVPictureInPictureControllerDelegate {
    let playerLayer: AVPlayerLayer
    
    private let player: AVPlayer
    private var pipController: AVPictureInPictureController?
    
    override init() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playback, mode: .moviePlayback)
            try audioSession.setActive(true, options: [])
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        if let url = Bundle.main.url(forResource: "Race480", withExtension: "mp4") {
            self.player = AVPlayer(url: url)
        } else {
            self.player = AVPlayer()
        }
        
        self.playerLayer = AVPlayerLayer(player: player)
        if AVPictureInPictureController.isPictureInPictureSupported() {
            self.pipController = AVPictureInPictureController(playerLayer: playerLayer)
        }
        
        super.init()
        self.pipController?.delegate = self
    }
    
    func toggle() {
        guard let pipController else { return }
        
        if pipController.isPictureInPictureActive {
            pipController.stopPictureInPicture()
            player.isMuted = true
        } else {
            player.isMuted = false
            pipController.startPictureInPicture()
        }
    }
    
    func start() {
        player.isMuted = true
        player.play()
    }
    
    func stop() {
        player.isMuted = true
        player.pause()
        player.seek(to: .zero)
    }
}
