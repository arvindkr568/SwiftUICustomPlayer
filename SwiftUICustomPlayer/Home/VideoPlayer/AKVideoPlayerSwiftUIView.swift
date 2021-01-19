//
//  AKVideoPlayerSwiftUIView.swift
//  SwiftUICustomPlayer
//
//  Created by Arvind on 19/01/21.
//

import SwiftUI
import AVKit

struct AKVideoPlayerSwiftUIView: UIViewRepresentable {
    
    let player: AVPlayer
    let frame: CGRect
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AKVideoPlayerSwiftUIView>) {
    }
    
    func makeUIView(context: UIViewRepresentableContext<AKVideoPlayerSwiftUIView>) -> UIView {
        return VideoPlayerUIView(frame: frame, player: player)
    }
}

//struct AKVideoPlayerSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        AKVideoPlayerSwiftUIView(player: <#AVPlayer#>)
//    }
//}

class VideoPlayerUIView: UIView {
  private let playerLayer = AVPlayerLayer()
  private let player: AVPlayer
    
   init(frame: CGRect, player: AVPlayer) {
    self.player = player
    super.init(frame: frame)

    player.play()
    playerLayer.player = player
    playerLayer.frame = frame
    playerLayer.videoGravity = .resizeAspect
    layer.addSublayer(playerLayer)
  }
    
  required init?(coder: NSCoder) {
   fatalError("init(coder:) has not been implemented")
  }
    
  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer.frame = bounds
  }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
