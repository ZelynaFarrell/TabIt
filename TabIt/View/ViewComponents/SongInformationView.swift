//
//  SongInformationView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/10/23.
//

import FirebaseAuth
import SwiftUI

struct SongInformationView: View {
    @EnvironmentObject var songViewModel: SongViewModel
    
    @State private var isPressed = false
    @State private var isBackPressed = false
    @State private var isSavePressed = false
    
    @State private var showSavedConfirmation = false
    @State private var heartScale: CGFloat = 1.0
    @State private var buttonScale: CGFloat = 1.0
    
    let songSaver = SongSaver()
    
    var body: some View {
        VStack {
            Spacer()
            
            SongTitleAndArtistView()
            
            Spacer()
            
            SongButtonsView(
                isPressed: $isPressed,
                isBackPressed: $isBackPressed,
                isSavePressed: $isSavePressed,
                showSavedConfirmation: $showSavedConfirmation,
                heartScale: $heartScale,
                buttonScale: $buttonScale,
                onSaveButtonTap: onSaveButtonTap,
                onBackButtonTap: onBackButtonTap,
                onTabItButtonTap: onTabItButtonTap
            )
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(alignment: .top)
        .animation(.easeInOut(duration: 0.3), value: songViewModel.isIdentified)
    }
    
    private func onSaveButtonTap() {
        isSavePressed = true
        showSavedConfirmation = true
        heartScale = 1.5
        buttonScale = 0.9
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            heartScale = 1.0
            buttonScale = 1.0
            isSavePressed = false
            showSavedConfirmation = false
            songViewModel.reset()
        }
        
        if let songTitle = songViewModel.songTitle, let songArtist = songViewModel.songArtist {
            if let userID = Auth.auth().currentUser?.uid {
                songSaver.saveSong(songTitle: songTitle, songArtist: songArtist, userID: userID)
            }
        }
    }
    
    private func onBackButtonTap() {
        withAnimation(.easeIn.delay(0.5)) {
            songViewModel.reset()
        }
    }
    
    private func onTabItButtonTap() {
        withAnimation {
            songViewModel.openUltimateGuitarTab()
        }
    }
}

struct SongInformationView_Previews: PreviewProvider {
    static var previews: some View {
        SongInformationView()
            .environmentObject(SongViewModel())
    }
}

