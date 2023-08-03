//
//  TopBarView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/26/23.
//

import SwiftUI

struct TopBarView: View {
    @EnvironmentObject var songViewModel: SongViewModel
    @Binding var isMenuOpen: Bool
    
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    if !songViewModel.isListening && !songViewModel.isWorking {
                        Button {
                            isMenuOpen.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 35))
                                .foregroundColor(.white.opacity(0.4))
                        }
                        .padding(.top, 20)
                        .padding(.leading, 20)
                        .zIndex(1)
                        
                        if songViewModel.hasError {
                            Button {
                                songViewModel.hasError = false
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 25)).bold()
                                    .foregroundColor(.white.opacity(0.4))
                            }
                            .padding(.top, 20)
                            .padding(.leading, 20)
                            .zIndex(1)
                        }
                        
                    }
                    
                }
                Spacer()
            }
            Spacer()
        }
    }// end of someview
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(isMenuOpen: .constant(false))
            .environmentObject(SongViewModel())
    }
}
