//
//  LoginActionToggleView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/27/23.
//

import SwiftUI

struct LoginActionToggleView: View {
    @Binding var isNewUser: Bool
    
    var body: some View {
        HStack {
            Text(isNewUser ? "Already have an account?" : "Don't have an account?")
                .font(.headline)
                .foregroundColor(.white)
            
            Button {
                isNewUser.toggle()
            } label: {
                Text(isNewUser ? "Log In" : "Sign Up")
                    .font(.headline).bold()
                    .foregroundColor(.cyan)
            }
        }
    }
}

struct LoginActionToggleView_Previews: PreviewProvider {
    static var previews: some View {
        LoginActionToggleView(isNewUser: .constant(false))
    }
}
