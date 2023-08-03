//
//  SongInfo.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/10/23.
//

import Foundation

struct SongInfo: Codable {
    let result: SongResult?
    let status: String?
}

struct SongResult: Codable {
    let artist: String?
    let title: String?
    let album: String?
    let releaseDate: String?
    let label: String?
    let timecode: String?
    let songLink: String?
    
    enum CodingKeys: String, CodingKey {
        case artist
        case title
        case album
        case releaseDate = "release_date"
        case label
        case timecode
        case songLink = "song_link"
    }
}
