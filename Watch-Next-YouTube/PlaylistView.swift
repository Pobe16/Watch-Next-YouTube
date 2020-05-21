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
    @State private var expandedArchives: Set<Video> = []
    
    func adaptForSmallScreen() -> Bool {
        switch horizontalSizeClass {
        case .compact:
            return true
        default:
            return false
        }
    }
    
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
    
    func tapArchiveFilm(for video: Video) {
        if expandedArchives.contains(video) {
            expandedArchives.remove(video)
        } else {
            expandedArchives.removeAll()
            expandedArchives.insert(video)
        }
    }
    
    func getOpacity (for videoInArchive: Video) -> Double {
        if expandedArchives.contains(videoInArchive) {
            return 1.0
        } else {
            return 0.5
        }
    }
    
    
    var body: some View {
        
        ZStack() {
            ScrollView(.vertical, content: {
                Spacer()
                    .frame(height: 135)
                ScrollView(.horizontal, content: {
                    
                    HStack(spacing: 30) {
                        ForEach(archive) { item in
                            
                            HStack(spacing: 0) {
                                Image(item.imageName)
                                    .resizable()
                                    .aspectRatio(1.777, contentMode: .fill)
                                    .frame(height: 120)
                                    .onTapGesture {
                                        self.tapArchiveFilm(for: item)
                                    }
                                
                                if self.expandedArchives.contains(item) {
                                    VStack(alignment: .leading ) {
                                        Text(item.title)
                                            .padding(.top, 10)
                                            .padding(.horizontal, 10)
                                            .frame(width: 200)
                                            .clipped()
                                        
                                        Spacer()
                                        
                                        HStack {
                                            Text("Add again?")
                                                .padding(.leading, 10)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "plus.circle.fill")
                                                .resizable()
                                                .foregroundColor(.green)
                                                .frame(width: 30,
                                                       height: 30)
                                                .padding(.bottom, 10)
                                                .padding(.trailing, self.adaptForSmallScreen() ? 4 : 10)
                                        }
        
                                    }
                                        .background(Color("background_regular"))
                                }
                            }
                                .background(Color("background_regular"))
                                .cornerRadius(15).shadow(color: Color("background_shadow_dark"), radius: 5, x: 10, y: 10)
                                .shadow(color: Color("background_shadow_light"), radius: 5, x: -10, y: -10)
                                .padding()
                                .opacity(self.getOpacity(for: item))
                        }
                    }
                })
                    .padding()
                    .frame(height: 150)
                    .animation(.linear(duration: 0.2))
                
                ForEach(playlist) { (item: Video) in
                    HStack {
                        Text("⋮")
                            .font(Font.system(size: 60))
                            .fontWeight(.black)
                            .frame(width: 25.0)
                            .padding(0)
                            .foregroundColor(.gray)
                        
                        Image(item.imageName)
                            .resizable()
                            .aspectRatio(1.777, contentMode: .fit)
                            .frame(height: 150.0)
                            .cornerRadius(20)
                            .shadow(color: Color("background_shadow_dark"), radius: 5, x: 10, y: 10)
                            .shadow(color: Color("background_shadow_light"), radius: 5, x: -10, y: -10)
                        
                        Spacer()
                            .frame(width: 25.0)
                        
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .lineLimit(1)
                                .minimumScaleFactor(0.75)
                                .font(.largeTitle)
                            Text("by " + item.author)
                                .font(.body)
                            Text(self.formatViews(item.numberOfViews) + " views")
                                .foregroundColor(.secondary)
                                .padding(.bottom)
                            Spacer()
                            HStack{
                                Text(self.formatDuration(from: item.duration))
                                    .font(.body)
                                    .padding()
                                    .frame(width:150)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.clear, lineWidth: 4)
                                            .shadow(color: Color("background_shadow_dark"), radius: 3, x: 5, y: 5)
                                            .shadow(color: Color("background_shadow_light"), radius: 3, x: -5, y: -5)
                                    )
                                    .cornerRadius(5)
                                Spacer()
                                
                                Button(action: { print("Delete video \(item.id)") }) {
                                    Image(systemName: "minus.circle.fill")
                                        .resizable()
                                        .background(Color.white)
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(16)
                                        .foregroundColor(.red)
                                        .opacity(0.5)
                                        .padding(.trailing)
                                    
                                }
                                
                            }
                            
                        }
                    }
                }
                Spacer()
                    .frame(height: 125)
            })
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
            
            PlaylistView()
                .previewDevice(PreviewDevice(rawValue: "iPhone Xs Max"))
            .previewDisplayName("iPhone Xs Max")
        }
        
    }
}
