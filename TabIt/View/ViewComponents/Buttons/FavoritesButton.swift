//
//  FavoritesButton.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/26/23.
//

import SwiftUI

struct FavoritesButton: View {
    @Binding var isMenuOpen: Bool
    @Binding var isShowingFavorites: Bool
    
    @State private var isFavoritesPressed = false
    @State private var heartScale: CGFloat = 1.0
    @State private var favoritesButtonScale: CGFloat = 1.0
    
    var body: some View {
        Button {
            withAnimation(.interpolatingSpring(stiffness: 100, damping: 10, initialVelocity: 5)) {
                isFavoritesPressed = true
                heartScale = 1.5
                favoritesButtonScale = 0.9
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    heartScale = 1.0
                    favoritesButtonScale = 1.0
                    isFavoritesPressed = false

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isShowingFavorites = true
                        isMenuOpen = false
                    }
                }
            }
        } label: {
            HStack(spacing: 5) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.white)

                Text("Favorites")
                    .font(.custom("Caprasimo-Regular", size: 28))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color.blue.opacity(0.8))
                    .shadow(color: Color.blue.opacity(0.4), radius: 8, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue.opacity(0.8), lineWidth: 2)
                    )
            )
        }
        .frame(height: 120)
        .scaleEffect(favoritesButtonScale)
        .overlay(
            // Heart animation
            Image(systemName: "heart.fill")
                .font(.system(size: 25))
                .foregroundColor(.red)
                .opacity(isFavoritesPressed ? 0.8 : 0)
                .offset(y: -50)
                .scaleEffect(heartScale)
                .animation(.interpolatingSpring(stiffness: 100, damping: 10, initialVelocity: 5), value: heartScale)
        )
    }// end of some view
}

struct FavoritesButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesButton(isMenuOpen: .constant(false), isShowingFavorites: .constant(false))
    }
}
