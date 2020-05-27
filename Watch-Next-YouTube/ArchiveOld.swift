//
//  ArchiveOld.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 27/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct ArchiveOld: View {
    var archive: [Video] = Archive.current
    @State private var expandedArchives: Set<Video> = []
    
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
                                                .padding(.trailing, 10)
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
    }
}

struct ArchiveOld_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveOld()
    }
}
