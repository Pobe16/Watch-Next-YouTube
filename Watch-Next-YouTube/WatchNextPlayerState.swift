//
//  WatchNextPlayerState.swift
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
    case idle
    case stop
}

class WatchNextPlayerState: ObservableObject {
    let objectDidChange = PassthroughSubject<WatchNextPlayerState, Never>()
    
    private var previousPlayerSize: playerSizeState = .inline
    var videoState: playerCommandToExecute = .loadNewVideo
    
    @Published var videoID: String = "w8MQGxIZ3kQ" {
        didSet {
            self.objectDidChange.send(self)
            self.executeCommand = .loadNewVideo
        }
    }
    
    @Published var playerSize: playerSizeState = .inline{
        didSet { self.objectDidChange.send(self) }
        
    }
    
    @Published var minimiseAlignment: Alignment = .topLeading {
        didSet { self.objectDidChange.send(self) }
    }
    
    @Published var executeCommand: playerCommandToExecute = .idle {
        didSet { self.objectDidChange.send(self) }
    }
    
    @Published var videoDuration: Double = 0 {
        didSet { self.objectDidChange.send(self) }
    }
    
    @Published var currentTime: Double = 0 {
        didSet { self.objectDidChange.send(self) }
    }
    
    func showVideo() {
        minimiseAlignment = .topLeading
        playerSize = .inline
    }
    
    func hideVideo() {
        playerSize = .hidden
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
            executeCommand = .pause
            videoState = .pause
        } else if videoState == .pause {
            executeCommand = .play
            videoState = .play
        } else {
            print("Unknown player state, attempring playing")
            executeCommand = .play
            videoState = .play
        }
    }
    
    func forwardDoubleTapped() {
        executeCommand = .forward
    }
    
    func backwardDoubleTapped() {
        executeCommand = .backward
    }
    
    static var shared = WatchNextPlayerState()
}
