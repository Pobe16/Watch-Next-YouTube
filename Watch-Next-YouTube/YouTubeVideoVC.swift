//
//  YouTubeVideoVC.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 27/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI
import UIKit
import YouTubePlayer

final class YTView: UIViewRepresentable {
    
    typealias UIViewType = YouTubePlayerView
    
    
    
    @ObservedObject var playerState: WatchNextPlayerState
    
    init(playerState: WatchNextPlayerState) {
        self.playerState = playerState
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(playerState: playerState)
    }
                
    func makeUIView(context: Context) -> UIViewType {
        let playerVars = [
            "controls": "0",
            "playsinline": "0",
            "autohide": "0",
            "autoplay": "0",
            "fs": "1",
            "rel": "0",
            "loop": "0",
            "enablejsapi": "1",
            "modestbranding": "1"
        ]
        
        let ytVideo = YouTubePlayerView()
        
        ytVideo.playerVars = playerVars as YouTubePlayerView.YouTubePlayerParameters
        ytVideo.delegate = context.coordinator
        print("creatingview")
        
        return ytVideo
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        if !(playerState.executeCommand == .idle) && uiView.ready {
            switch playerState.executeCommand {
            case .loadNewVideo:
                playerState.executeCommand = .idle
                uiView.loadVideoID(playerState.videoID)
            case .play:
                uiView.play()
            case .pause:
                uiView.pause()
            case .forward:
                uiView.getCurrentTime { (time) in
                    guard let time = time else {return}
                    uiView.seekTo(Float(time) + 5, seekAhead: true)
                }
            case .backward:
                uiView.getCurrentTime { (time) in
                    guard let time = time else {return}
                    uiView.seekTo(Float(time) - 5, seekAhead: true)
                }
            default:
                print("\(playerState.executeCommand) not yet implemented")
            }
        } else if !uiView.ready {
            uiView.loadVideoID(playerState.videoID)
        }
        
    }
    
    class Coordinator: YouTubePlayerDelegate {
        @ObservedObject var playerState: WatchNextPlayerState
        
        var positionTimer: Timer?
        
        init(playerState: WatchNextPlayerState) {
            self.playerState = playerState
        }
        
        func playerReady(_ videoPlayer: YouTubePlayerView) {
            videoPlayer.getDuration { (time) in
                guard let unwrappedTime = time else { return }
                self.playerState.videoDuration = unwrappedTime
            }
            videoPlayer.play()
            playerState.videoState = .play
        }
        
        func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
            
            switch playerState {
            case .Playing:
                positionTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(setCurrentTime), userInfo: videoPlayer, repeats: true)
            case .Paused, .Ended:
                positionTimer?.invalidate()
            default:
                print("\(playerState) not implemented")
            }
            

        }
        
        @objc func setCurrentTime() {
            let videoPlayer = positionTimer?.userInfo as! YouTubePlayerView as YouTubePlayerView
            videoPlayer.getCurrentTime { (time) in
                guard let unwrappedTime = time else { return }
                self.playerState.currentTime = unwrappedTime
            }
        }
    }
    
    
}


