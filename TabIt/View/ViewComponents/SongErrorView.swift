//
//  SongErrorView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/11/23.
//

import SwiftUI

struct SongErrorView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Song Error")
                .font(.system(.largeTitle, design: .rounded)).bold()
            
            Text("Try Again")
                .font(.system(.title2, design: .rounded)).bold()
                .padding(.bottom, 50)
            
            MicButton()
        }
        .foregroundColor(.white)
        .padding()
    }
}

struct SongErrorView_Previews: PreviewProvider {
    static var previews: some View {
        SongErrorView()
    }
}
