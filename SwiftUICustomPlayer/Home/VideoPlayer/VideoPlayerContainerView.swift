//
//  VideoPlayerContainerView.swift
//  SwiftUICustomPlayer
//
//  Created by Arvind on 19/01/21.
//

import SwiftUI
import AVFoundation

// This is the SwiftUI view which contains the player and its controls
struct VideoPlayerContainerView : View {
    // The progress through the video, as a percentage (from 0 to 1)
    @State private var videoPos: Double = 0
    // The duration of the video in seconds
    @State private var videoDuration: Double = 0
    // Whether we're currently interacting with the seek bar or doing a seek
    @State private var seeking = false
    
    private let player: AVPlayer
    private var frame: CGRect
  
    init(url: URL, frame: CGRect) {
        self.frame = frame
        player = AVPlayer(url: url)
    }
  
    var body: some View {
        VStack {
            ZStack {
                AKVideoPlayerSwiftUIView(videoPos: $videoPos, videoDuration: $videoDuration, seeking: $seeking, player: player, frame: frame).frame(minWidth: 0, maxWidth: .infinity,  minHeight: frame.height, maxHeight: frame.height, alignment: .top)
            VideoPlayerControlsView(videoPos: $videoPos, videoDuration: $videoDuration, seeking: $seeking, player: player, frame: frame)
            }.zIndex(1)
            
        }
        .onDisappear {
            // When this View isn't being shown anymore stop the player
            self.player.replaceCurrentItem(with: nil)
        }
        Spacer()
    }
}

struct VideoPlayerContainerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerContainerView(url: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!, frame: .zero)
    }
}
