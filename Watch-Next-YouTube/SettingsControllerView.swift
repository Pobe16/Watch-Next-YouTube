//
//  SettingsControllerView.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 21/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct SettingsControllerView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("Settings")
            Spacer()
            SignInWithApple()
                .frame(width: 280, height: 60)
            Spacer()
        }
    }
}

struct SettingsController_Previews: PreviewProvider {
    static var previews: some View {
        SettingsControllerView()
    }
}
