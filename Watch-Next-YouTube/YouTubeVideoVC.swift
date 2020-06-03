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

class YouTubeVideoVC: UIViewController {
    
    var videoID: String?{
        didSet{
            self.loadVideo()
        }
    }
    var playlistID: String?
    var updatecounter = 0
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

    var videoPlayer = YouTubePlayerView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        videoPlayer.playerVars = playerVars as YouTubePlayerView.YouTubePlayerParameters
        configureYTView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    func configureYTView() {
        
        view.addSubview(videoPlayer)
        
        videoPlayer.translatesAutoresizingMaskIntoConstraints = false
        videoPlayer.delegate = self
        
        NSLayoutConstraint.activate([
            videoPlayer.topAnchor.constraint(equalTo: view.topAnchor),
            videoPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            videoPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func loadVideo() {
        
        if let currentVideoID = videoID {
            print("loading video \(currentVideoID)")
            videoPlayer.loadVideoID(currentVideoID)
        } else {
            if let currentPlaylistID = playlistID {
                videoPlayer.loadPlaylistID(currentPlaylistID)
            } else {
                return
            }
        }
    }
    
    func playVideo() {
        videoPlayer.play()
    }
    
    func pauseVideo() {
        videoPlayer.pause()
    }
    
    func forward() {
        videoPlayer.getCurrentTime { (time) in
            guard let time = time else {return}
            self.videoPlayer.seekTo(Float(time) + 5, seekAhead: true)
        }
    }
    
    func backward() {
        videoPlayer.getCurrentTime { (time) in
            guard let time = time else {return}
            self.videoPlayer.seekTo(Float(time) - 5, seekAhead: true)
        }
    }

}

extension YouTubeVideoVC: YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        print("player ready")
        playVideo()
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        print(playerState)
    }
}

final class YTView: UIViewControllerRepresentable {
    
    var playerState: WatchNextPlayerState
    
    init(playerState: WatchNextPlayerState) {
        self.playerState = playerState
    }
                
    func makeUIViewController(context: Context) -> YouTubeVideoVC {
        print(playerState.videoID)
        return YouTubeVideoVC()
    }
    
    func updateUIViewController(_ uiViewController: YouTubeVideoVC, context: Context) {
        print("###")
        print("ytupdate")
        print("###")
        if playerState.videoID != uiViewController.videoID {
            uiViewController.videoID = playerState.videoID
        }
        
        if !(playerState.executeCommand == .idle) && uiViewController.videoPlayer.ready {
            switch playerState.executeCommand {
            case .play:
                uiViewController.playVideo()
            case .pause:
                uiViewController.pauseVideo()
            case .forward:
                uiViewController.forward()
            case .backward:
                uiViewController.backward()
            default:
                print("\(playerState.executeCommand) not yet implemented")
            }
        }
        
    }
    
    
}


