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
    
    @State var selectedOptionPanel: Int? = 7
    
    var body: some View {
        
        NavigationView{
            List() {
                
                Section(
                    header: Text("App Settings")
                ){
                    NavigationLink(destination: EmptyView(), tag: 0, selection: $selectedOptionPanel) {
                        Image(systemName: "play.circle.fill")
                            .foregroundColor(.green)
                        Text("Play Settings")
                    }
                    NavigationLink(destination: EmptyView(), tag: 1, selection: $selectedOptionPanel) {
                        Image(systemName: "timer")
                            .foregroundColor(.orange)
                        Text("Archive Settings")
                    }
                    NavigationLink(destination: EmptyView(), tag: 2, selection: $selectedOptionPanel) {
                        Image(systemName: "gear")
                            .foregroundColor(.black)
                        Text("General Settings")
                    }
                }
                
                Section(
                    header: Text("User Data")
                ){
                    NavigationLink(destination: EmptyView(), tag: 3, selection: $selectedOptionPanel) {
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.blue)
                        Text("Import Playlist")
                    }
                    NavigationLink(destination: EmptyView(), tag: 4, selection: $selectedOptionPanel) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.green)
                        Text("Export Playlist")
                    }
                }
                
                Section(
                    header: Text("Legal")
                ){
                    NavigationLink(destination: EmptyView(), tag: 5, selection: $selectedOptionPanel) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .foregroundColor(.orange)
                        Text("Terms of Service")
                    }
                    NavigationLink(destination: EmptyView(), tag: 6, selection: $selectedOptionPanel) {
                        Image(systemName: "hand.raised")
                            .foregroundColor(.green)
                        Text("Privacy Policy")
                    }
                }
                
                Section(
                    header: Text("Account Settings")
                ){
                    NavigationLink(destination: AccountAuthorizationScreen(), tag: 7, selection: $selectedOptionPanel) {
                        Image(systemName: "person")
                            .foregroundColor(.orange)
                        Text("Edit Account Settings")
                    }
                    NavigationLink(destination: EmptyView(), tag: 8, selection: $selectedOptionPanel) {
                        Image(systemName: "escape")
                            .foregroundColor(.black)
                        Text("Log out")
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
                    NavigationLink(destination: EmptyView(), tag: 0, selection: $selectedOptionPanel) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.red)
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


