//
//  LogOutButton.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/26/23.
//

import FirebaseAuth
import SwiftUI

struct LogOutButton: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var photoManager: PhotoManager
    @EnvironmentObject var songViewModel: SongViewModel
    
    @Binding var isMenuOpen: Bool
    @State private var shouldRotate = false
    
    var body: some View {
        Button {
            withAnimation(.linear(duration: 1.0)) {
                shouldRotate.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                logout()
            }
        } label: {
            HStack(spacing: 5) {
                Image(systemName: "power")
                    .font(.system(size: 25)).bold()
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(shouldRotate ? 360 : 0))
                    .animation(.linear(duration: 1.0), value: shouldRotate)

                Text("Log Out")
                    .font(.custom("Caprasimo-Regular", size: 28))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)

            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color.red.opacity(0.8))
                    .shadow(color: Color.red.opacity(0.4), radius: 8, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.red.opacity(0.8), lineWidth: 2)
                    )
            )
        }

    }// end of some view
    private func logout() {
        authViewModel.logoutUser { error in
            if let error = error {
                print("Logout error: \(error.localizedDescription)")
            } else {
                songViewModel.reset()
                photoManager.reset()
                
                authViewModel.isUserLoggedIn = false
                authViewModel.userID = nil
                
                UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                isMenuOpen = false
            }
        }
    }

}

struct LogOutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogOutButton(isMenuOpen: .constant(false))
            .environmentObject(AuthViewModel())
            .environmentObject(PhotoManager())
    }
}
