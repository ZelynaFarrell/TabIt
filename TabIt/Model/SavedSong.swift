//
//  SavedSong.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/13/23.
//

import Foundation

struct SavedSong: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let timestamp: Date
    let userID: String

    init(title: String, artist: String, timestamp: Date, userID: String) {
        self.title = title
        self.artist = artist
        self.timestamp = timestamp
        self.userID = userID
    }
}


