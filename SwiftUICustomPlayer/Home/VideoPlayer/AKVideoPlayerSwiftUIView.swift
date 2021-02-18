//
//  AKVideoPlayerSwiftUIView.swift
//  SwiftUICustomPlayer
//
//  Created by Arvind on 19/01/21.
//

import SwiftUI
import AVKit

struct AKVideoPlayerSwiftUIView: UIViewRepresentable {
    @Binding private(set) var videoPos: Double
    @Binding private(set) var videoDuration: Double
    @Binding private(set) var seeking: Bool
    
    let player: AVPlayer
    let frame: CGRect
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AKVideoPlayerSwiftUIView>) {
    }
    
    func makeUIView(context: UIViewRepresentableContext<AKVideoPlayerSwiftUIView>) -> UIView {
        return VideoPlayerUIView(frame: frame, player: player, videoPos: $videoPos, videoDuration: $videoDuration, seeking: $seeking)
    }
}

//struct AKVideoPlayerSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        AKVideoPlayerSwiftUIView(player: <#AVPlayer#>)
//    }
//}

class VideoPlayerUIView: UIView {
    private let videoPos: Binding<Double>
    private let videoDuration: Binding<Double>
    private let seeking: Binding<Bool>
    private var durationObservation: NSKeyValueObservation?
    private var timeObservation: Any?
    
  private let playerLayer = AVPlayerLayer()
  private let player: AVPlayer
       
    init(frame: CGRect, player: AVPlayer, videoPos: Binding<Double>, videoDuration: Binding<Double>, seeking: Binding<Bool>) {
        self.player = player
        self.videoDuration = videoDuration
        self.videoPos = videoPos
        self.seeking = seeking
        
        super.init(frame: .zero)
    
        backgroundColor = .lightGray
        playerLayer.player = player
        layer.addSublayer(playerLayer)
        
        // Observe the duration of the player's item so we can display it
        // and use it for updating the seek bar's position
        durationObservation = player.currentItem?.observe(\.duration, changeHandler: { [weak self] item, change in
            guard let self = self else { return }
            self.videoDuration.wrappedValue = item.duration.seconds
        })
        
        // Observe the player's time periodically so we can update the seek bar's
        // position as we progress through playback
        timeObservation = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600), queue: nil) { [weak self] time in
            guard let self = self else { return }
            // If we're not seeking currently (don't want to override the slider
            // position if the user is interacting)
            guard !self.seeking.wrappedValue else {
                return
            }
        
            // update videoPos with the new video time (as a percentage)
            self.videoPos.wrappedValue = time.seconds / self.videoDuration.wrappedValue
        }
    }
  required init?(coder: NSCoder) {
   fatalError("init(coder:) has not been implemented")
  }
    
  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer.frame = bounds
  }
}
