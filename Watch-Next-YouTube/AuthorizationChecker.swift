//
//  MainView.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 21/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit
import SwiftUI

struct AuthorizationChecker: View {
    
    @EnvironmentObject var firebaseAccount: FirebaseAccountAuthorization
   
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "background_regular")
    }
    
    func getUser () {
        firebaseAccount.listen()
        print(firebaseAccount.currentUser?.uid ?? "uid not found")
    }

    var body: some View {
        Group {
            if firebaseAccount.currentUser != nil {
                TabView {
                    PlaylistView()
                        .tabItem {
                            VStack{
                                Image(systemName: "list.bullet")
                                Text("Playlist")
                            }
                    }
                    SettingsControllerView()
                    .tabItem {
                        VStack{
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                    }
                }
                .accentColor(.green)
            } else {
                AccountAuthorizationScreen()
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationChecker()
        .environmentObject(FirebaseAccountAuthorization())
    }
}
