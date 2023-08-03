//
//  ProfileContent.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/26/23.
//

import SwiftUI
import PhotosUI

struct ProfileContent: View {
    @EnvironmentObject var photoManager: PhotoManager

    @Binding var showSaveButton: Bool
    @Binding var photosPickerItem: PhotosPickerItem?
    
     @State private var originalProfileImage: UIImage? = nil

    var body: some View {
        Section {
            PhotosPicker(selection: $photosPickerItem) {
                
                if let image = photoManager.profileImage {
                    ZStack {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 160, height: 160)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.7), lineWidth: 10)
                            )
                        
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 140)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                    }
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 100))
                            .foregroundColor(.gray)
                            .frame(width: 160, height: 160)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                        
                        Text("Tap to choose\nprofile photo")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            
            if showSaveButton {
                HStack(spacing: 10) {

                    Button {
                        if let originalImage = originalProfileImage {
                            photoManager.profileImage = originalImage
                        } else {
                            photoManager.profileImage = nil
                        }

                        showSaveButton = false

                    } label: {
                        Image(systemName: "x.square.fill")
                    }
                    .font(.subheadline).bold()
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.red.opacity(0.7))
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 2)
                    .padding(.top)

                    
                    Button {
                        if let image = photoManager.profileImage {
                            photoManager.uploadProfileImage(userID: photoManager.userID, image: image) { error in
                                if let error = error {
                                    print("Error uploading profile image: \(error.localizedDescription)")
                                }
                            }
                            originalProfileImage = image
                        }
                        
                        showSaveButton = false
                        
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.down")
                            Text("Save to Profile")
                        }
                        .font(.subheadline).bold()
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.green.opacity(0.7))
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 5, x: 0, y: 2)
                        .padding(.top)
                    }
                }
            }
            
        }
        .transition(.opacity)
        .onAppear {
            originalProfileImage = photoManager.profileImage
        }
    }// end of some view
}

struct ProfileContent_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContent(showSaveButton: .constant(false), photosPickerItem: .constant(nil))
            .environmentObject(PhotoManager())
    }
}
