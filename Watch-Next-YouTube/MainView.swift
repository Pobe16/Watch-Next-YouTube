//
//  MainView.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 27/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            WatchNext()
            .tabItem {
                Image(systemName: "play.circle.fill")
                Text("Watch Next")
            }
            
            PlaylistView()
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Playlist")
            }
            
            PlaylistView()
            .tabItem {
                Image(systemName: "timer")
                Text("Archive")
            }
            
            SettingsControllerView()
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .accentColor(.green)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
