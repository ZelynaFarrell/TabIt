//
//  RecordingView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/10/23.
//

import SwiftUI

struct RecordingView: View {
    @EnvironmentObject var songViewModel: SongViewModel
    
    var body: some View {
        VStack {
            WaveFormView()
            
            Text("\(songViewModel.countdown)")
                .font(.system(size: 90, weight: .bold, design: .rounded))
                .foregroundColor(.white).opacity(0.4)
                .shadow(color: .black, radius: 5, x: 0, y: 3)
                .scaleEffect(songViewModel.contentScale)
                .padding(.vertical, 50)
            
        }
        .animation(.easeInOut(duration: 0.3), value: songViewModel.isListening)
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
            .environmentObject(SongViewModel())
    }
}

