//
//  YouTubeInterface.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 03/06/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct YouTubeInterface: View {
    @EnvironmentObject var playerState: YouTubeControlState
    @State var showInterface: Bool = true
    
    @State var interfaceTimer: Timer?
    
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
    
    func showFullScreenButton() {
        if playerState.videoState == .pause {
            showInterface = true
        } else {
            interfaceTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
                if self.playerState.videoState == .pause {
                    self.interfaceTimer?.invalidate()
                    self.showInterface = true
                } else {
                    self.showInterface = false
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
//            YouTubeView()
            
            YouTubeView(playerState: playerState)
//                .edgesIgnoringSafeArea(.bottom)
                .onTapGesture {
                    self.showInterface = true
                    self.showFullScreenButton()
                }
            
            VStack(alignment: .trailing) {
                Spacer()
//                HStack(spacing: 0){
//                    Rectangle().foregroundColor(Color("button_transparent"))
//                    .onTapGesture(count: 2) {
//                        self.playerState.backwardDoubleTapped()
//                    }
//                    Rectangle().foregroundColor(Color("button_transparent"))
//                    .onTapGesture {
//                        self.playerState.playPauseButtonTapped()
//                    }
//                    Rectangle().foregroundColor(Color("button_transparent"))
//                    .onTapGesture(count: 2) {
//                        self.playerState.forwardDoubleTapped()
//                    }
//                }
                if showInterface {
                    HStack(alignment: .bottom){
                        Spacer()
                        Image(systemName: self.playerState.playerSize == .fullscreen ?
                            "arrow.down.right.and.arrow.up.left" :
                            "arrow.up.left.and.arrow.down.right" )
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding()
                        .onAppear(perform: showFullScreenButton)
                        .onTapGesture{
                            self.playerState.fullScreenButtonTapped()
                        }
                    }
                }
            }
        }
    }
}

//struct YouTubeInterface_Previews: PreviewProvider {
//    static var previews: some View {
//        YouTubeInterface().environmentObject(YouTubeControlState())
//            .previewLayout(.fixed(width: 600, height: 400))
//    }
//}
