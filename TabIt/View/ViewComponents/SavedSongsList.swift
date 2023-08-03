//
//  SavedSongsList.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/26/23.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct SavedSongsList: View {
    @EnvironmentObject var songViewModel: SongViewModel
    @Environment(\.presentationMode) var presentationMode
    
    private let firestore: Firestore
    @Binding private var savedSongs: [SavedSong]
    
    init(firestore: Firestore, savedSongs: Binding<[SavedSong]>) {
        self.firestore = firestore
        _savedSongs = savedSongs
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            List {
                ForEach(savedSongs) { song in
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(song.artist)
//                                .font(.custom("Calistoga-Regular", size: 25))
                                .font(.title)
                                .bold()
                            
                                .foregroundColor(.white)
                                .lineLimit(1)
                            Text(song.title)
//                                .font(.custom("Calistoga-Regular", size: 18))
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.6))
                                .lineLimit(2)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing, 10)
                    }
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .padding()
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.gray.opacity(0.2))
                                .overlay(
                                    LinearGradient(
                                        gradient: Gradient(stops: [
                                            .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)), location: 0),
                                            .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)), location: 0.8)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                    .mask(
                                        RoundedRectangle(cornerRadius: 10)
                                    )
                                )
                                .shadow(color: .black.opacity(0.6), radius: 8, x: 0, y: 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white.opacity(0.1), lineWidth: 3)
                                        .padding(2)
                                )
                        }
                    )
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        songViewModel.songTitle = song.title
                        songViewModel.songArtist = song.artist
                        songViewModel.openUltimateGuitarTab()
                    }
                }
                .onDelete(perform: deleteSong)
            }
            .listStyle(.plain)
            .background(Color.clear)
        }
        
    }// end of some view
    
    
    private func deleteSong(at offsets: IndexSet) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in.")
            return
        }
        
        let songsToDelete = offsets.map { savedSongs[$0] }
        songsToDelete.forEach { song in
            let collectionRef = firestore.collection("savedSongs")
            let query = collectionRef.whereField("userID", isEqualTo: userID)
                .whereField("title", isEqualTo: song.title)
                .whereField("artist", isEqualTo: song.artist)
                .limit(to: 1)
            
            query.getDocuments { snapshot, error in
                if let error = error {
                    print("Failed to delete song: \(error.localizedDescription)")
                    return
                }
                
                guard let document = snapshot?.documents.first else {
                    print("Song document not found")
                    return
                }
                
                collectionRef.document(document.documentID).delete { error in
                    if let error = error {
                        print("Failed to delete song: \(error.localizedDescription)")
                    } else {
                        print("Song deleted successfully")
                        savedSongs.removeAll { $0.id == song.id }
                    }
                }
            }
        }
    }
}

struct SavedSongsList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SavedSongsList(firestore: Firestore.firestore(), savedSongs: .constant([
                SavedSong(title: "Song Title 1", artist: "Artist 1", timestamp: Date(), userID: "user1"),
                SavedSong(title: "Song Title 2", artist: "Artist 2", timestamp: Date(), userID: "user2"),
                SavedSong(title: "Song Title 3", artist: "Artist 3", timestamp: Date(), userID: "user3")
            ]))
            .environmentObject(SongViewModel())
        }
    }
}
