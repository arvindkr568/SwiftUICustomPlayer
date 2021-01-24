//
//  ControllsSwiftUIView.swift
//  SwiftUICustomPlayer
//
//  Created by Arvind on 19/01/21.
//

import SwiftUI
import AVFoundation

struct VideoPlayerControlsView : View {
    @Binding private(set) var videoPos: Double
    @Binding private(set) var videoDuration: Double
    @Binding private(set) var seeking: Bool
    
    let player: AVPlayer
    
    @State private var playerPaused = true
    let frame: CGRect
    let stripHeight = CGFloat(25.0)
    
    var body: some View {
  
            VStack {
                VStack {
                    // Play/pause button
                    Button(action: togglePlayPause) {
                        Image(systemName: playerPaused ? "play" : "pause").resizable().frame(width: stripHeight, height: stripHeight, alignment: .center).foregroundColor(.white)
                    }
                }.frame(width: stripHeight, height: frame.height - stripHeight, alignment: .center)
                HStack {
                    Text(Utility.formatSecondsToHMS(videoPos * videoDuration)).padding(.leading, 5)
                        
                    Button(action: togglePlayPause) {
                        Image(systemName: playerPaused ? "play" : "pause").frame(width: stripHeight - 5, height: stripHeight - 5, alignment: .center).foregroundColor(.white)
                    }
                    
                    Slider(value: $videoPos, in: 0...1, onEditingChanged: sliderEditingChanged)
                    
                    Text(Utility.formatSecondsToHMS(videoDuration)).padding(5)
                    
                    Button(action: settingClicked) {
                        Image("setting").resizable().frame(width: 20, height: 20, alignment: .center).foregroundColor(.white)
                    }.padding(.trailing, 5)
                    
                    Button(action: enlarzeClicked) {
                        Image("enlarge").resizable().frame(width: 20, height: 20, alignment: .center)
                    }.padding(.trailing, 5)
                    
                    Button(action: pipClicked) {
                        Image("pip")
                    }.padding(.trailing, 5)
                    
                }//.frame(minWidth: frame.width, maxWidth: .infinity, minHeight: stripHeight, maxHeight: stripHeight, alignment: .bottomLeading)
            }

    }
    
    private func settingClicked () {
        print("Setting icon clicked")
    }
    
    private func pipClicked () {
        print("pip icon clicked")
    }
    
    private func enlarzeClicked () {
        print("full screen icon clicked")
    }
    
    private func togglePlayPause() {
        pausePlayer(!playerPaused)
        print("play pause button clickd")
    }
    
    private func pausePlayer(_ pause: Bool) {
        playerPaused = pause
        if playerPaused {
            player.pause()
        }
        else {
            player.play()
        }
    }
    
    private func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            // Set a flag stating that we're seeking so the slider doesn't
            // get updated by the periodic time observer on the player
            seeking = true
            pausePlayer(true)
        }
        
        // Do the seek if we're finished
        if !editingStarted {
            let targetTime = CMTime(seconds: videoPos * videoDuration,
                                    preferredTimescale: 600)
            player.seek(to: targetTime) { _ in
                // Now the seek is finished, resume normal operation
                self.seeking = false
                self.pausePlayer(false)
            }
        }
    }
}


