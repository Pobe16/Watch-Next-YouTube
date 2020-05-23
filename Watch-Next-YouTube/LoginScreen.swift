//
//  LoginScreen.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 23/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct LoginScreen: View {
    var body: some View {
        VStack{
            Text("Welcome back! Please log in here:")
                .font(.largeTitle)
            
            SignInWithApple()
            .frame(width: 280, height: 60)
            
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
