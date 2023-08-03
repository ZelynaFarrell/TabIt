//
//  FirebaseManager.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/20/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class FirebaseManager {
    static let shared = FirebaseManager()
    private let db: Firestore

    private init() {
        db = Firestore.firestore()
    }

    func fetchSavedSongs(userID: String, completion: @escaping (Result<[SavedSong], Error>) -> Void) {
        let collectionRef = db.collection("savedSongs")
        let query = collectionRef.whereField("userID", isEqualTo: userID)

        query.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }

            let savedSongs: [SavedSong] = documents.compactMap { document in
                let data = document.data()
                guard let title = data["title"] as? String,
                      let artist = data["artist"] as? String,
                      let timestamp = data["timestamp"] as? Timestamp
                else {
                    return nil
                }

                let song = SavedSong(title: title, artist: artist, timestamp: timestamp.dateValue(), userID: userID)
                return song
            }

            completion(.success(savedSongs))
        }
    }

}
