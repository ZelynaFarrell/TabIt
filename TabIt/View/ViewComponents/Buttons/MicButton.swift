//
//  MicButton.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/10/23.
//

import SwiftUI

struct MicButton: View {
    @EnvironmentObject var songViewModel: SongViewModel
    @State private var isPressed = false
    
    var body: some View {
        Group {
            Image(systemName: "mic.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.white).opacity(isPressed ? 0.7 : 1)
                .shadow(color: .black, radius: 5, x: 0, y: 3)
                .frame(width: 140, height: 140)
                .background(Color.blue).opacity(isPressed ? 0.7 : 1)
                .clipShape(Circle())
                .scaleEffect(isPressed ? 0.7 : 1)
        }
        .pressEvents {
            withAnimation(.easeIn(duration: 0.2)) {
                isPressed = true
            }
        } onRelease: {
            withAnimation {
                isPressed = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    songViewModel.startRecording()

                }
            }
        }
        .transition(.scale(scale: isPressed ? 0.7 : 1, anchor: .center))
    }
}

struct MicButton_Previews: PreviewProvider {
    static var previews: some View {
        MicButton()
            .environmentObject(SongViewModel())
    }
}
