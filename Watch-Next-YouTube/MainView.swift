//
//  MainView.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 21/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    VStack{
                        Image(systemName: "list.bullet")
                        Text("Playlist")
                    }
            }
            SettingsControllerView()
            .tabItem {
                VStack{
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
