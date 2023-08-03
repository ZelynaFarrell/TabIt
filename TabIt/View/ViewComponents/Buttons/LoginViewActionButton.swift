//
//  LoginViewActionButton.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/27/23.
//

import SwiftUI

struct LoginViewActionButton: View {
    @Binding var isPressed: Bool
      var isFormValid: Bool
      var isNewUser: Bool
      
      var action: () -> Void
    
    var body: some View {
        Group {
            Text(isNewUser ? "Sign Up" : "Log In")
                .font(.headline).bold()
                .foregroundColor(isNewUser ? .yellow.opacity(isFormValid ? 1 : 0.5) : .white .opacity(isFormValid ? 1 : 0.5)).opacity(isPressed ? 0.7 : 1)
                .padding()
                .frame(width: 220, height: 50)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.4), Color.black.opacity(0.3)]), startPoint: .top, endPoint: .bottom).opacity(isPressed ? 0.7 : 1)
                        .cornerRadius(25)
                )
                .overlay(
                    Capsule()
                        .stroke(.black.opacity(0.5), style: StrokeStyle(lineWidth: 6))
                        .padding(-4)
                )
                .shadow(radius: 10)
                .mask(RoundedRectangle(cornerRadius: 25).padding(.bottom, -10))
                .scaleEffect(isPressed ? 0.9 : 1)
        }
        .pressEvents {
            withAnimation(.easeIn(duration: 0.2)) {
                isPressed = true
            }
        } onRelease: {
            withAnimation {
                isPressed = false

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    action()
                }
            }
        }
        .disabled(!isFormValid)
    }
}

struct LoginViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewActionButton(
            isPressed: .constant(false),
            isFormValid: true,
            isNewUser: true,
            action: {}
        )
    }
}

