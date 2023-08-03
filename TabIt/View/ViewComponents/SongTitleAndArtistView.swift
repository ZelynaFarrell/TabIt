//
//  SongTitleAndArtistView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/26/23.
//

import SwiftUI

struct SongTitleAndArtistView: View {
    @EnvironmentObject var songViewModel: SongViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            if let songTitle = songViewModel.songTitle {
                Text(songTitle)
//                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .font(.custom("Caprasimo-Regular", size: 50))
                    .foregroundColor(.white)
            }
            
            if let songArtist = songViewModel.songArtist {
                Text(songArtist)
//                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .font(.custom("Caprasimo-Regular", size: 40))
                    .foregroundColor(.white)
                    .opacity(0.5)
            }
        }
        .opacity(songViewModel.isIdentified ? 1 : 0)
        .animation(.easeInOut(duration: 0.5), value: songViewModel.isIdentified)
        .transition(.opacity)
    }
}

struct SongTitleAndArtistView_Previews: PreviewProvider {
    static var previews: some View {
        SongTitleAndArtistView()
            .environmentObject(SongViewModel())
    }
}
