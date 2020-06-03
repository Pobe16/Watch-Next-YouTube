//
//  MainView.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 27/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var playerState: WatchNextPlayerState
    
//    @ObservedObject var playerState: WatchNextPlayerState = WatchNextPlayerState()
    
    func decideHeight(size: CGSize) -> CGFloat {
        switch playerState.playerSize {
        case .fullscreen:
//            return size.height
            return UIScreen.main.bounds.height
        case .hidden:
            return 0
        case .inline:
            return size.width * 0.6 / 1.777
        case .miniplayer:
            return size.width * 0.25 / 1.777
        }
    }
    
    func decideWidth(size: CGSize) -> CGFloat {
        switch playerState.playerSize {
        case .fullscreen:
            return size.width
        case .hidden:
            return 0
        case .inline:
            return size.width * 0.6
        case .miniplayer:
            return size.width * 0.25
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: self.playerState.minimiseAlignment) {
                TabView {
                    MovieDetails()
                    .onAppear(perform: self.playerState.showVideo)
                    .tabItem {
                        Image(systemName: "play.circle.fill")
                        Text("Watch Next")
                    }
                    
                    PlaylistView()
                    .onAppear(perform: self.playerState.hideVideo)
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Playlist")
                    }
                    
                    PlaylistView()
                    .onAppear(perform: self.playerState.makeMiniPlayer)
                    .tabItem {
                        Group{
                        Image(systemName: "timer")
                        Text("Archive")
                        }
                    }
                    
                    SettingsControllerView()
                    .onAppear(perform: self.playerState.hideVideo)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .accentColor(.green)
                
                YouTubeInterface()
                .animation(.easeInOut(duration: 0.3))
                .background(Color.clear)
                .edgesIgnoringSafeArea(self.playerState.playerSize == .fullscreen ? .all : .leading)
                .frame(
                    width: self.decideWidth(size: geometry.size),
                    height: self.decideHeight(size: geometry.size)
                )
                .padding(.bottom, self.playerState.playerSize == .miniplayer ? geometry.size.height / 10 : 0
                )
                .padding(.trailing, self.playerState.playerSize == .miniplayer ? geometry.size.width / 20 : 0
                )
                
            
            
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
