//
//  PlaylistView.swift
//  watch-next-swift-ui-test
//
//  Created by Mikolaj Lukasik on 15/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct PlaylistView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let playlist: [Video] = Playlist.current
    var archive: [Video] = Archive.current
        
    func formatDuration(from seconds: Double) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional

        return formatter.string(from: TimeInterval(seconds))!
    }
    
    func formatViews(_ views: Int) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .none
        
        return formatter.string(from: NSNumber(value: views))!
    }
    
    func sumDuration(for playlist: [Video] ) -> String {
        var duration = 0.0
        playlist.forEach { (video) in
            duration += video.duration
        }
        return formatDuration(from: duration)
    }
    
    
    var body: some View {
        
        ZStack() {
            VStack{
//            ScrollView(.vertical, content: {
                
                Spacer()
                .frame(height: 135)
                
                ArchiveOld()
                PlaylistVideoList(playlist: playlist)
                
                Spacer()
                .frame(height: 125)
                
//            })
            }
            .background(Color("background_regular"))
            
            
            
            
            VStack {
                HStack{
                    Button( action: { print("tapped autoplay") }) {
                        Text("Autoplay")
                            .font(.title)
                            .frame(height: 30.0)
                            .padding(15)
                            .foregroundColor(Color.black)
                            .background(LinearGradient(gradient: Gradient(colors: [Color("positive_dark"), Color("positive_light")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.clear, lineWidth: 4)
                                    .shadow(color: Color("background_shadow_dark"), radius: 5, x: 5, y: 5)
                                    .shadow(color: Color("background_shadow_light"), radius: 5, x: -5, y: -5)
                            )
                            .cornerRadius(5)
                            .shadow(color: Color("background_shadow_dark"), radius: 5, x: 5, y: 5)
                            .shadow(color: Color("background_shadow_light"), radius: 5, x: -5, y: -5)
                            
                        
                    }
                    
                    .padding(.leading, 20)
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                    
                    
                    Spacer()
                    
                    Button( action: { print("tapped clear") }) {
                        Text("Clear playlist")
                            .font(.title)
                            .frame(height: 30.0)
                            .padding(15)
                            .foregroundColor(Color(.label))
                            .background(LinearGradient(gradient: Gradient(colors: [Color("background_shadow_light"), Color("background_shadow_dark")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(5)
                            .shadow(color: Color("background_shadow_dark"), radius: 5, x: 5, y: 5)
                            .shadow(color: Color("background_shadow_light"), radius: 5, x: -5, y: -5)
                                                        
                                                    
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                    .padding(.trailing, 20)
                    
                    Button( action: { print("tapped options") }) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                            .padding(15)
                            .foregroundColor(Color(.label))
                            .background(LinearGradient(gradient: Gradient(colors: [Color("background_shadow_light"), Color("background_shadow_dark")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(5)
                            .shadow(color: Color("background_shadow_dark"), radius: 5, x: 5, y: 5)
                            .shadow(color: Color("background_shadow_light"), radius: 5, x: -5, y: -5)
                                                        
                                                    
                    }
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)
                    
                    
                }
                    .background(Color("background_transparent"))
                    .frame(alignment: .top)
                    .clipped()
                    .shadow(color: Color("background_shadow_dark"), radius: 5, x: 0, y: 10)
                
                Spacer()
                
                HStack(alignment: .top) {
                    Spacer()
                    Text("Playlist time: " + self.sumDuration(for: playlist))
                        .font(.title)
                    Spacer()
                    
                }
                    .frame(height: 50)
                    .background(Color("background_transparent"))
                    .padding(0)
                    .clipped()
                    .shadow(color: Color("background_shadow_dark"), radius: 5, x: 10, y: 10)
                    .shadow(color: Color("background_shadow_light"), radius: 5, x: 0, y: -10)
            }
            
            
                        
        }
            .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            PlaylistView()
            .previewDisplayName("Current Build")
        }
        
    }
}
