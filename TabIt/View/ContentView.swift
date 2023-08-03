//
//  ContentView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/5/23.
//

import FirebaseAuth
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var photoManager: PhotoManager
    @AppStorage("isUserLoggedIn") var isUserLoggedIn = false
    @State private var isMenuOpen = false
    @State private var hasCheckedLoginStatus = false

    var body: some View {
        NavigationView {
            VStack {
                if authViewModel.isUserLoggedIn || isUserLoggedIn {
                    HomeView(isMenuOpen: $isMenuOpen)
                        .onDisappear {
                            isMenuOpen = false
                        }
                } else {
                    LoginView(isUserLoggedIn: $isUserLoggedIn)
                }
            }
            .navigationBarHidden(true)
            .modifier(GradientBackground())
            .onReceive(photoManager.$userID) { userID in
                if let imageURL = URL(string: photoManager.profileImageURLString), photoManager.profileImage == nil {
                    photoManager.loadProfileImage(url: imageURL)
                }
            }
            .onAppear {
                if !hasCheckedLoginStatus {
                    authViewModel.checkLoginStatus()
                    hasCheckedLoginStatus = true
                }
            }
        }
        .environmentObject(authViewModel)
        .environmentObject(photoManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
            .environmentObject(PhotoManager())
    }
}
