//
//  SavedSongsView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/13/23.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct SavedSongsView: View {
    @EnvironmentObject var songViewModel: SongViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isLoadingData = false
    @State private var savedSongs: [SavedSong] = []
    
    private let firestore = Firestore.firestore()
    private let songSaver = SongSaver()
    
    var body: some View {
        VStack {
            SavedSongsHeader()
            
            Spacer()
            
            Group {
                if isLoadingData {
                    ProcessingView()
                        .transition(.opacity)
                } else {
                    if savedSongs.isEmpty {
                        VStack {
                            Text("No saved songs")
                                .font(.title).bold()
                                .foregroundColor(.white)
                        }
                    } else {
                        SavedSongsList(firestore: firestore, savedSongs: $savedSongs)
                    }
                }
            }
            Spacer()
        }
        .modifier(GradientBackground())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            isLoadingData = true
            fetchSavedSongs()
        }
    }
    
    private func fetchSavedSongs() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in.")
            return
        }
        
        FirebaseManager.shared.fetchSavedSongs(userID: userID) { result in
            isLoadingData = false
            
            switch result {
            case .success(let savedSongs):
                self.savedSongs = savedSongs.sorted(by: { $0.timestamp > $1.timestamp })
            case .failure(let error):
                print("Failed to fetch saved songs: \(error.localizedDescription)")
            }
        }
    }
}

struct SavedSongsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedSongsView()
            .environmentObject(SongViewModel())
    }
}
