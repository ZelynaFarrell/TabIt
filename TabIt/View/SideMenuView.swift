//
//  SideMenuView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/13/23.
//

import PhotosUI
import FirebaseAuth
import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var photoManager: PhotoManager

    @Binding var isMenuOpen: Bool
    @Binding var isShowingFavorites: Bool

    @State private var photosPickerItem: PhotosPickerItem?
    @State private var showSaveButton = false
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button {
                    isMenuOpen = false
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24))
                        .foregroundColor(.white.opacity(0.5))
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.top, 20)
            
            ProfileContent(showSaveButton: $showSaveButton, photosPickerItem: $photosPickerItem)
            
            Rectangle()
                .frame(height: 4)
                .foregroundColor(Color.gray.opacity(0.4))
                .padding()
                .padding(.bottom, 20)
            
            FavoritesButton(isMenuOpen: $isMenuOpen, isShowingFavorites: $isShowingFavorites)
                .padding(.horizontal)
            
            LogOutButton(isMenuOpen: $isMenuOpen)
                .padding(.horizontal)

            Spacer()
            
        }
        .frame(width: 250)
        .animation(.easeInOut(duration: 0.4), value: showSaveButton)
        .animation(.easeInOut, value: photoManager.profileImage)
        .onChange(of: photosPickerItem) { selectedPhotosPickerItem in
          guard let selectedPhotosPickerItem else {
            return
          }
          Task {
            await updatePhotosPickerItem(with: selectedPhotosPickerItem)
          }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)), Color(#colorLiteral(red: 0.25, green: 0.25, blue: 0.25, alpha: 1))]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.2), lineWidth: 4)
                .ignoresSafeArea()
        )
    }
    private func updatePhotosPickerItem(with item: PhotosPickerItem) async {
        withAnimation {
            photosPickerItem = item
            showSaveButton = true
        }
        
        if let photoData = try? await item.loadTransferable(type: Data.self) {
            if let image = UIImage(data: photoData) {
                photoManager.profileImage = image
            } else {
                // Handle error when converting data to UIImage
                print("Error converting data to UIImage.")
            }
        } else {
            // Handle error when loading image data from `photosPickerItem`
            print("Error loading image data from `photosPickerItem`.")
        }
    }

}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isMenuOpen: .constant(false), isShowingFavorites: .constant(false))
            .environmentObject(AuthViewModel())
            .environmentObject(PhotoManager())
    }
}
