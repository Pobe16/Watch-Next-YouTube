//
//  WatchNext.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 27/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct MovieDetails: View {
//    @ObservedObject var playerState: WatchNextPlayerState
    
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 10) {
                VStack{
                    Spacer()
                    .aspectRatio(1.777, contentMode: .fit)
                        .frame(width: geometry.size.width * 0.6)
                        
                    
                    Spacer()
                    
                    Text("Movie Details Placeholder")
                    .font(.title)
                    
                    Spacer()
                    
                    
                }
                VStack{
                    Text("Coming next:")
                        .font(.title)
                    
                    PlaylistVideoList( playlist: Playlist.current)
                    .clipped()
                }
            }
            .background(Color("background_regular"))
        }
    }
}

struct WatchNext_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails()
    }
}
