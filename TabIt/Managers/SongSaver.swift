//
//  SongSaver.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/13/23.
//

import Firebase
import FirebaseFirestore

struct SongSaver {
    func saveSong(songTitle: String, songArtist: String, userID: String) {
        let db = Firestore.firestore()
        
        let songData: [String: Any] = [
            "title": songTitle,
            "artist": songArtist,
            "timestamp": Date(),
            "userID": userID
        ]
        
        db.collection("savedSongs").addDocument(data: songData) { error in
            if let error = error {
                print("Error saving song: \(error.localizedDescription)")
            } else {
                print("Song saved successfully: \(songTitle) - \(songArtist)")
            }
        }
    }
}
