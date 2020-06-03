//
//  YouTubeInterface.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 03/06/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct YouTubeInterface: View {
    @EnvironmentObject var playerState: WatchNextPlayerState
    
    var body: some View {
        ZStack {
            YTView(playerState: self.playerState)
            HStack(spacing: 0){
                Rectangle().foregroundColor(Color("button_transparent"))
                .onTapGesture(count: 2) {
                    self.playerState.backwardDoubleTapped()
                }
                Rectangle().foregroundColor(Color("button_transparent"))
                .onTapGesture {
                    self.playerState.playPauseButtonTapped()
                }
                Rectangle().foregroundColor(Color("button_transparent"))
                .onTapGesture(count: 2) {
                    self.playerState.forwardDoubleTapped()
                }
            }
        }
    }
}

struct YouTubeInterface_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeInterface().environmentObject(WatchNextPlayerState())
            .previewLayout(.fixed(width: 600, height: 400))
    }
}
