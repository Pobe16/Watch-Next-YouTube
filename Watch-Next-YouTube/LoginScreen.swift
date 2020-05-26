//
//  LoginScreen.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 23/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct LoginScreen: View {
    
    @EnvironmentObject var firebaseAccount: FirebaseAccountAuthorization
    
    var body: some View {
        VStack{
            Text("Welcome back! Please log in here:")
                .font(.largeTitle)
            
            ContinueWithApple()
            .frame(width: 280, height: 60)
            .onTapGesture {
                self.showAppleLogin()
            }
            
            ExtractedView()
            
        }
    }
    
    private func showAppleLogin() {
        
        firebaseAccount.startSignInWithAppleFlow()
        
    }
    
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

struct ExtractedView: View {
    
    @EnvironmentObject var firebaseAccount: FirebaseAccountAuthorization
    
    var body: some View {
        Button(action: {
            self.logOut()
        }) {
            Text("Log out")
        }
    }
    
    private func logOut() {
        let _ = firebaseAccount.signOut()
    }
    
}
