//
//  SettingsControllerView.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 21/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct SettingsControllerView: View {
    
    init() {
        let backgroundCell = UIView()
        backgroundCell.backgroundColor = UIColor(named: "positive_dark")
        
        UINavigationBar.appearance().backgroundColor = UIColor(named: "background_shadow_light")
        UITableView.appearance().backgroundColor = UIColor(named: "background_shadow_light")
        UITableViewCell.appearance().backgroundColor = UIColor(named: "background_regular")
        UITableViewCell.appearance().selectedBackgroundView = backgroundCell
        
    }
    
    var body: some View {
        
        NavigationView (){
            List {
                
                Section(
                    header: Text("App Settings")
                ){
                    NavigationLink(destination: EmptyView()) {
                        Text("Playlist Settings")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Archive Settings")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("General Settings")
                    }
                }
                
                Section(
                    header: Text("User Data")
                ){
                    NavigationLink(destination: EmptyView()) {
                        Text("Import Playlist")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Export Playlist")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Edit Account Settings")
                    }
                }
                
                Section(
                    header: Text("Legal")
                ){
                    NavigationLink(destination: EmptyView()) {
                        Text("Terms of Service")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Privacy Policy")
                    }
                }
                
                Section(
                    header: Text("Danger Zone"),
                    footer: HStack{
                        Spacer()
                        Text("Created by Miko \"Pobe\" Lukasik")
                        Spacer()
                    }
                ){
                    NavigationLink(destination: EmptyView()) {
                        Text("Log out")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Delete Account")
                            .foregroundColor(.red)
                    }
                }
                
                
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Watch Next Control Menu", displayMode: .inline)
            
            AccountAuthorizationScreen()
                .background(Color("background_regular"))
                .navigationBarTitle("Account")
                
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
//         THIS IS A HACK!!!
//         adding padding to the navigation view displays it in the same way as UISplitViewController on the iPad in Vertical Mode
        .padding(.all, 1)
    }
}

struct SettingsController_Previews: PreviewProvider {
    static var previews: some View {
        SettingsControllerView()
//            .colorScheme(.dark)
    }
}


