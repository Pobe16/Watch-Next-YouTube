//
//  SignInWithApple.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 19/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI
import AuthenticationServices

// 1
final class SignInWithApple: UIViewRepresentable {
  // 2
  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    // 3
    return ASAuthorizationAppleIDButton()
  }
  
  // 4
  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
  }
}
