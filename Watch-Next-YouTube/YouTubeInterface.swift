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
    @State var showInterface: Bool = true
    @State var sliderValue: Double = 0
    
    func formatDuration(from seconds: Double) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        if seconds >= 3600 {
            formatter.allowedUnits.insert(.hour)
        }
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional

        return formatter.string(from: TimeInterval(seconds))!
    }
    
    var body: some View {
        ZStack {
//            YTView()
            
            YTView(playerState: self.playerState)
            
            VStack {
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
                if showInterface {
                    HStack{
                        Image(systemName: self.playerState.videoState == .pause || self.playerState.videoState == .stop ? "play.circle.fill" : "pause.circle.fill")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .padding()
                        .onTapGesture {
                            self.playerState.playPauseButtonTapped()
                        }
                        Text(formatDuration(from: playerState.currentTime))
                        Slider(value: $playerState.currentTime, in: 0...playerState.videoDuration)
                        Text(formatDuration(from: playerState.videoDuration))
                    }
                    .frame(height: 50)
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                }
            }
        }
    }
}

//struct YouTubeInterface_Previews: PreviewProvider {
//    static var previews: some View {
//        YouTubeInterface().environmentObject(WatchNextPlayerState())
//            .previewLayout(.fixed(width: 600, height: 400))
//    }
//}
