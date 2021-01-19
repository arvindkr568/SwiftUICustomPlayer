//
//  HomeSwiftUIView.swift
//  SwiftUICustomPlayer
//
//  Created by Arvind on 12/01/21.
//

import SwiftUI

struct HomeSwiftUIView: View {
    var body: some View {
        //Text("Hello, Home view!")
        VStack(content: {
           let url = URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!
            VideoPlayerContainerView(url: url, frame: CGRect.init(x: 0, y: 0, width: UIScreen.screenWidth, height: 200))
            
        })
        
       
    }
}

struct HomeSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSwiftUIView()
    }
}
