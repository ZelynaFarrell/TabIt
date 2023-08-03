//
//  AuthViewModel.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/20/23.
//

import FirebaseAuth
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isUserLoggedIn = false
    var userID: String?
    
    func checkLoginStatus() {
        if let currentUser = Auth.auth().currentUser {
            isUserLoggedIn = true
            userID = currentUser.uid
            print("Checking log in status with checkLoginStatus - setting id to: \(userID ?? "")")
        } else {
            isUserLoggedIn = false
            userID = nil
        }
    }
    
    func signUp(email: String, password: String, photoManager: PhotoManager, completion: @escaping (AuthError?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Signup error: \(error.localizedDescription)")
                completion(AuthError(message: error.localizedDescription))
            } else {
                let userID = authResult?.user.uid ?? ""
                print("User signed up and logged in. Here is the userID: \(userID)")
                
                // Set the userID in the PhotoManager
                photoManager.userID = userID
                
                self.isUserLoggedIn = true
                completion(nil)
            }
        }
    }
    
    func login(email: String, password: String, photoManager: PhotoManager, completion: @escaping (AuthError?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Handle login error
                print("Login error: \(error.localizedDescription)")
                completion(AuthError(message: error.localizedDescription))
            } else {
                let userID = authResult?.user.uid ?? ""
                print("Login successful for userID: \(userID)")
                
                // Set the userID in the PhotoManager
                photoManager.userID = userID
                
                // Fetch the profile image URL after logging in
                photoManager.fetchProfileImageURL(userID: userID) { url, error in
                    if let imageURL = url {
                        // Update the profileImageURL after fetching
                        DispatchQueue.main.async {
                            photoManager.profileImageURLString = imageURL.absoluteString
                            photoManager.loadProfileImage(url: imageURL)
                        }
                        
                    } else {
                        // Handle error, if any
                        print("Error fetching profile image URL: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }

                self.isUserLoggedIn = true
                completion(nil)
            }
        }
    }



    
    
    func logoutUser(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
