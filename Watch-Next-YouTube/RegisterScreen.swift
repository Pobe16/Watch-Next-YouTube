//
//  RegisterScreen.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 26/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

struct RegisterScreen: View {
    
    @EnvironmentObject var firebaseAccount: FirebaseAccountAuthorization
    
    var body: some View {
        VStack{
            Text("Hello, please register:")
                .font(.largeTitle)
            
            SignInWithApple()
            .frame(width: 280, height: 60)
            .onTapGesture {
                self.showAppleLogin()
            }
            
        }
    }
    
    
    
    private func showAppleLogin() {
        
        firebaseAccount.startSignInWithAppleFlow()
        
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
