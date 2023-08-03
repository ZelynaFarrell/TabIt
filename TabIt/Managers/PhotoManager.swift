//
//  PhotoManager.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/21/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

class PhotoManager: ObservableObject {
    @Published var profileImage: UIImage? = nil
    @AppStorage("profileImageURL") var profileImageURLString: String = ""
    @Published var userID: String = "" {
        didSet {
            // Load the profile image from the URL when userID is set
            if let imageURL = URL(string: profileImageURLString) {
                loadProfileImage(url: imageURL)
            }
        }
    }

    private let storage = Storage.storage()
    private var downloadTask: URLSessionDataTask?

    func uploadProfileImage(userID: String, image: UIImage, completion: @escaping (Error?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(NSError(domain: "com.zelynaS.TabIt", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get image data"]))
            return
        }

        let imageRef = storage.reference().child("profileImages/\(userID).jpg")

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        imageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                completion(error)
            } else {
                // Get the download URL of the uploaded image
                imageRef.downloadURL { url, error in
                    if let imageURL = url {
                        // Store the download URL as a String in UserDefaults
                        UserDefaults.standard.set(imageURL.absoluteString, forKey: "profileImageURL")
                        UserDefaults.standard.synchronize()

                        // Update the profileImageURL after fetching
                        self.profileImageURLString = imageURL.absoluteString
                        print("Profile image uploaded and URL updated: \(imageURL)")

                        completion(nil)
                    } else {
                        // Handle error, if any
                        print("Error fetching profile image URL: \(error?.localizedDescription ?? "Unknown error")")
                        // Call completion with the error
                        completion(error)
                    }
                }
            }
        }
    }


    func fetchProfileImageURL(userID: String, completion: @escaping (URL?, Error?) -> Void) {
        let imageRef = storage.reference().child("profileImages/\(userID).jpg")

        imageRef.downloadURL { url, error in
            if let error = error {
                // Handle the case where the image URL does not exist
                print("Error fetching profile image URL: \(error.localizedDescription)")
                completion(nil, error)
            } else {
                completion(url, nil)
            }
        }
    }
    
    func loadProfileImage(url: URL) {
        guard profileImage == nil && !profileImageURLString.isEmpty else {
            return
        }

        downloadTask?.cancel() // Cancel any ongoing download task

        downloadTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to download profile image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            DispatchQueue.main.async {
                self?.profileImage = image
            }
        }

        downloadTask?.resume()
    }

    func reset() {
        userID = ""
        profileImage = nil
        profileImageURLString = ""
        downloadTask?.cancel()
        downloadTask = nil

    }
}
