//
//  SessionStore.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 23/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class SessionStore : ObservableObject {
    let objectDidChange = PassthroughSubject<SessionStore, Never>()
    @Published var currentUser: User? { didSet { self.objectDidChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.currentUser = user
//                (
//                    uid: user.uid,
//                    displayName: user.displayName
//                )
            } else {
                // if we don't have a user, set our session to nil
                print("User not found")
                self.currentUser = nil
            }
        }
    }

    // additional methods (sign up, sign in) will go here
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    
}
