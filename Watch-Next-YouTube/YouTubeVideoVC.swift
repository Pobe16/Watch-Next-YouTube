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
    
    var videoID: String? = "w8MQGxIZ3kQ"
    var playlistID: String?
    var updatecounter = 0

    var videoPlayer = YouTubePlayerView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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

}

extension YouTubeVideoVC: YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        print("player ready")
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        print(playerState)
    }
}

final class YTView: UIViewControllerRepresentable {
    
    @Binding var videoID: String
    
    init (videoID: Binding<String> = .constant("")) {
        _videoID = videoID
    }
            
    func makeUIViewController(context: Context) -> YouTubeVideoVC {
        return YouTubeVideoVC()
    }
    func updateUIViewController(_ uiViewController: YouTubeVideoVC, context: Context) {
        
        if videoID.count > 0 {
            uiViewController.videoID = videoID
        }
        
    }
    
    
}


