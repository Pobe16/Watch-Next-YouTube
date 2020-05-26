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
        UINavigationBar.appearance().backgroundColor = UIColor(named: "background_regular")
    }
    
    var body: some View {
        
        NavigationView (){
            List {
                Text("Option1")
            }
            .listStyle(GroupedListStyle())
            
            AccountAuthorizationScreen()
                .background(Color("background_regular"))
                .navigationBarTitle("Account")
                
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
            // THIS IS A HACK!!!
            // adding padding to the navigation view displays it in the same way as UISplitViewController on the iPad in Vertical Mode
        .padding(.all, 1)
    }
}

struct SettingsController_Previews: PreviewProvider {
    static var previews: some View {
        SettingsControllerView()
    }
}


