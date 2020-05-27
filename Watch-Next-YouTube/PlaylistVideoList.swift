//
//  PlaylistVideoList.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 27/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct PlaylistVideoList: View {
    
    var playlist: [Video]
    
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
        GeometryReader { geometry in
        ScrollView{
            ForEach(self.playlist) { (item: Video) in
                HStack {
                    Text("⋮")
                        .font(.title)
                        .fontWeight(.black)
                        .minimumScaleFactor(0.5)
                        .frame(width: min(geometry.size.width, geometry.size.height) / 20)
                        .padding(0)
                        .foregroundColor(.gray)
                    
                    Image(item.imageName)
                        .resizable()
                        .aspectRatio(1.777, contentMode: .fit)
                        .frame(width: min(geometry.size.width, geometry.size.height) / 4)
                        .cornerRadius(min(geometry.size.width, geometry.size.height) / 100)
                        .shadow(color: Color("background_shadow_dark"), radius: 5, x: 10, y: 10)
                        .shadow(color: Color("background_shadow_light"), radius: 5, x: -10, y: -10)
                    
                    Spacer()
                        .frame(width: min(geometry.size.width, geometry.size.height) / 25)
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                            .font(.title)
                        Text("by " + item.author)
                            .font(.body)
                            .minimumScaleFactor(0.5)
                        Text(self.formatViews(item.numberOfViews) + " views")
                            .foregroundColor(.secondary)
                            .font(.body)
                            .minimumScaleFactor(0.5)
                        Spacer(minLength: 1)
                        HStack{
                            Text(self.formatDuration(from: item.duration))
                                .font(.callout)
                                .padding()
                                .frame(width: min(geometry.size.width, geometry.size.height) / 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.clear, lineWidth: 4)
                                        .shadow(color: Color("background_shadow_dark"), radius: 3, x: 5, y: 5)
                                        .shadow(color: Color("background_shadow_light"), radius: 3, x: -5, y: -5)
                            )
                                .cornerRadius(5)
                            Spacer(minLength: 1)
                            
                            Button(action: { print("Delete video \(item.id)") }) {
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .frame(
                                        width: min(geometry.size.width, geometry.size.height) / 20,
                                        height: min(geometry.size.width, geometry.size.height) / 20)
                                    .foregroundColor(.red)
                                    .opacity(0.5)
                                    .padding(.trailing)
                                
                            }
                            
                        }
                        
                    }
                }
            }
        }
        .padding(.vertical)
        .background(Color("background_regular"))
        }
    }
}

struct PlaylistVideoList_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistVideoList(playlist: Playlist.current)
    }
}
