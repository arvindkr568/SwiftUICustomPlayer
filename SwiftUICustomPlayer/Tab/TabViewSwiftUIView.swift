//
//  TabViewSwiftUIView.swift
//  SwiftUICustomPlayer
//
//  Created by Arvind on 12/01/21.
//

import SwiftUI

struct TabViewSwiftUIView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.gray
    }
    
    @State var selected = 0
    var body: some View {
            TabView(selection: $selected) {
                HomeSwiftUIView().tabItem({
                    Image(systemName: Constants.TabBarImageName.tabBar0)
                        .font(.title)
                    Text("\(Constants.TabBarText.tabBar0)")
                }).tag(0)
                
                MoreSwiftUIView().tabItem({
                    Image(systemName: Constants.TabBarImageName.tabBar1)
                        .font(.title)
                    Text("\(Constants.TabBarText.tabBar1)")
                }).tag(1)
        }
    }
}

struct TabViewSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewSwiftUIView()
    }
}



struct Constants {
    
    struct TabBarImageName {
        static let tabBar0 = "gamecontroller.fill"
        static let tabBar1 = "person.fill"
        static let tabBar2 = "text.justify"
        static let tabBar3 = "cart.fill"
    }
    
    struct TabBarText {
        static let tabBar0 = "Home1"
        static let tabBar1 = "More"
        static let tabBar2 = "Blog"
        static let tabBar3 = "Store"
    }
}
