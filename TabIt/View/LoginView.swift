//
//  LoginView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/11/23.
//

import Firebase
import FirebaseAuth
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var photoManager: PhotoManager
    
    @State private var email = ""
    @State private var password = ""
    @State private var isNewUser = false
    
    @State private var isPressed = false
    
    @State private var showErrorAlert = false
    @State private var errorMessage: AuthError? = nil
    
    @Binding var isUserLoggedIn: Bool
    
    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    var body: some View {
        VStack {
            LogoTitleView()
            
            Spacer()
                .frame(height: 70)
            
            CustomTextField(placeholder: "Email", text: $email)
                .padding(.bottom, 20)
            
            CustomSecureTextField(placeholder: "Password", text: $password)
            
            
            Spacer()
                .frame(height: 70)
            
            
            LoginViewActionButton(isPressed: $isPressed, isFormValid: isFormValid, isNewUser: isNewUser) {
                if isNewUser {
                    authViewModel.signUp(email: email, password: password, photoManager: photoManager) { error in
                        if let error = error {
                            errorMessage = error
                        }
                    }
                } else {
                    authViewModel.login(email: email, password: password, photoManager: photoManager) { error in
                        if let error = error {
                            errorMessage = error
                        }
                    }
                }
            }
            
            Spacer()
                .frame(height: 25)
            
            LoginActionToggleView(isNewUser: $isNewUser)
            
            Spacer()
                .frame(height: 20)
        }
        .padding()
        .alert(isPresented: $showErrorAlert) {
            if let errorMessage = errorMessage {
                return Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
            } else {
                return Alert(title: Text("Error"), message: Text("Unknown error occurred"), dismissButton: .default(Text("OK")))
            }
        }
        .onChange(of: errorMessage) { newValue in
            showErrorAlert = newValue != nil
        }
    }// some view
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isUserLoggedIn: .constant(false))
            .environmentObject(AuthViewModel())
            .environmentObject(PhotoManager())
    }
}
