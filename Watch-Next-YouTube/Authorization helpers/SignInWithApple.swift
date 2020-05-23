//
//  SignInWithApple.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 19/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI
import AuthenticationServices

final class SignInWithApple: UIViewRepresentable {
    
    var buttonType: ASAuthorizationAppleIDButton.ButtonType = .default
        
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    
        let blackAppleAuthButton = ASAuthorizationAppleIDButton(type: .default, style: .black)
        let whiteAppleAuthButton = ASAuthorizationAppleIDButton(type: .default, style: .whiteOutline)

        let colorScheme = context.environment.colorScheme

        switch colorScheme {
        case .dark:
            return whiteAppleAuthButton
        case .light:
            return blackAppleAuthButton
        @unknown default:
            return blackAppleAuthButton
        }
    
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {

    }
}

struct SignInWithApple_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            VStack{
                SignInWithApple()
                    .frame(width: 280, height: 60)
            }
            .previewLayout(.fixed(width: 400, height: 100))
            .colorScheme(.light)
            .previewDisplayName("Light Mode")
            
            VStack{
                SignInWithApple()
                    .frame(width: 280, height: 60)
            }
            .previewLayout(.fixed(width: 400, height: 100))
            .colorScheme(.dark)
            .previewDisplayName("Dark Mode")
        }
    }
}
