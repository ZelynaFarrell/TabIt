//
//  SavedSongsHeader.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/27/23.
//

import SwiftUI

struct SavedSongsHeader: View {
    @EnvironmentObject var songViewModel: SongViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Button {
                songViewModel.reset()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.title2)
            }
            .padding(.horizontal)
            
            Text("Saved Songs")
                .font(.custom("Caprasimo-Regular", size: 35))
                .foregroundColor(.white.opacity(0.7))
            
            Spacer()
        }
        .padding(.bottom, 10)
    }
}

struct SavedSongsHeader_Previews: PreviewProvider {
    static var previews: some View {
        SavedSongsHeader()
            .environmentObject(SongViewModel())
    }
}
