//
//  YouTubeControlState.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 02/06/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI
import Combine

enum playerSizeState {
    case hidden
    case inline
    case miniplayer
    case fullscreen
}

enum playerCommandToExecute {
    case loadNewVideo
    case play
    case pause
    case forward
    case backward
    case stop
    case idle
}

class YouTubeControlState: ObservableObject {
    
    private var previousPlayerSize: playerSizeState = .inline
    @Published var videoState: playerCommandToExecute = .loadNewVideo
    
    @Published var videoID: String? // = "qRC4Vk6kisY"
    {
        didSet {
            self.executeCommand = .loadNewVideo
        }
    }
    
    @Published var playerSize: playerSizeState = .inline
    
    @Published var minimiseAlignment: Alignment = .topLeading
    
    @Published var executeCommand: playerCommandToExecute = .idle
    
    
    func showVideo() {
        minimiseAlignment = .topLeading
        playerSize = .inline
    }
    
    func hideVideo() {
        playerSize = .hidden
    }
    
    func fullScreenButtonTapped() {
        if playerSize == .fullscreen {
            exitFullScreen()
        } else {
            makeFullScreen()
        }
    }
    
    func makeFullScreen() {
        previousPlayerSize = playerSize
        playerSize = .fullscreen
    }
    
    func exitFullScreen() {
        playerSize = previousPlayerSize
    }
    
    func makeMiniPlayer() {
        minimiseAlignment = .bottomTrailing
        playerSize = .miniplayer
    }
    
    func playPauseButtonTapped() {
        if videoState == .play {
            pauseVideo()
        } else if videoState == .pause {
            playVideo()
        } else {
            print("Unknown player state, attempting playing")
            playVideo()
        }
    }
    
    func playVideo() {
        executeCommand = .play
    }
    
    func pauseVideo() {
        executeCommand = .pause
    }
    
    func forwardDoubleTapped() {
        executeCommand = .forward
    }
    
    func backwardDoubleTapped() {
        executeCommand = .backward
    }
}
