//
//  HomeView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/11/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var songViewModel: SongViewModel
    @EnvironmentObject var photoManager: PhotoManager
    @Binding var isMenuOpen: Bool
    @State private var isShowingFavorites = false
    
    /*
    init() {
        for familyName in UIFont.familyNames {
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("-- \(fontName)")
            }
        }
    }
     */

    var body: some View {
        ZStack {
            TopBarView(isMenuOpen: $isMenuOpen)
            
            if isMenuOpen {
                SideMenuView(isMenuOpen: $isMenuOpen, isShowingFavorites: $isShowingFavorites)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.trailing, UIScreen.main.bounds.width * 0.3)
                    .transition(.slide)
                    .zIndex(1)
            }

            VStack {
                if songViewModel.isListening {
                    RecordingView()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    
                } else if songViewModel.isWorking {
                    ProcessingAnimationView(size: 250, color: .blue)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    
                } else if songViewModel.songTitle != nil {
                    SongInformationView()
                        .transition(.opacity)
                    
                } else if songViewModel.hasError {
                    SongErrorView()
                        .transition(.opacity)
                } else {
                    if !isMenuOpen {
                        VStack(spacing: 30) {
                            Text("TabIt")
                                .font(.custom("Caprasimo-Regular", size: 70))
//                                .font(.system(size: 70, weight: .bold, design: .rounded))
                                .foregroundColor(.white)

                            MicButton()
                        }
                        .transition(.opacity)
                    }
                }
            }
            .multilineTextAlignment(.center)
            .animation(.easeInOut(duration: 0.2), value: isMenuOpen)
            .animation(.easeInOut(duration: 0.8), value: songViewModel.isListening)
            .animation(.easeInOut(duration: 0.8), value: songViewModel.isWorking)
            .animation(.easeInOut(duration: 0.8), value: songViewModel.isIdentified)
            .animation(.easeInOut(duration: 0.8), value: songViewModel.hasError)
        } //ZStack
        
        .onAppear {
            songViewModel.setupAudioSession()
        }
        .onDisappear {
            songViewModel.stopAudioSession()
        }
        .background(
            NavigationLink(destination: SavedSongsView(), isActive: $isShowingFavorites) {
                EmptyView()
            }
            .hidden()
        )
    
    }// end of someview
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isMenuOpen: .constant(false))
            .environmentObject(SongViewModel())
            .environmentObject(PhotoManager())
    }
}
