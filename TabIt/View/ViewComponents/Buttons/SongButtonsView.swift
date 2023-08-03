//
//  SongButtonsView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/26/23.
//

import SwiftUI

struct SongButtonsView: View {
    @EnvironmentObject var songViewModel: SongViewModel
    @Binding var isPressed: Bool
    @Binding var isBackPressed: Bool
    @Binding var isSavePressed: Bool
    @Binding var showSavedConfirmation: Bool
    @Binding var heartScale: CGFloat
    @Binding var buttonScale: CGFloat
    
    var onSaveButtonTap: () -> Void
    var onBackButtonTap: () -> Void
    var onTabItButtonTap: () -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Image(systemName: "waveform.circle")
                    .font(.system(size: 45))
                
                Text("TabIt")
//                    .font(.system(.largeTitle, design: .rounded))
                    .font(.custom("Caprasimo-Regular", size: 35))
//                    .bold()
            }
//            .font(.system(size: 40, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .opacity(isPressed ? 0.7 : 1)
            .shadow(color: .black, radius: 5, x: 0, y: 3)
            .frame(width: 180, height: 75)
            .background(Color.blue)
            .opacity(isPressed ? 0.7 : 1)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(.black.opacity(0.3), style: StrokeStyle(lineWidth: 10))
                    .padding(-2)
            )
            .shadow(radius: 10)
            .mask(RoundedRectangle(cornerRadius: 38).padding(.bottom, -8))
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
                    onTabItButtonTap()
                }
            }
        }
        .transition(.scale(scale: isPressed ? 0.7 : 1, anchor: .center))

        
        Spacer()
        

        HStack {
            Button {
                onBackButtonTap()
            } label: {
                Image(systemName: "arrow.left.circle.fill")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .padding(5)
                    .foregroundColor(.cyan)
                    .opacity(isBackPressed ? 0.9 : 1)
                    .background(.gray.opacity(0.5))
                    .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 3)
                    .clipShape(Circle())
                    .scaleEffect(isBackPressed ? 0.7 : 1)
            }
            .pressEvents {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isBackPressed = true
                }
            } onRelease: {
                withAnimation {
                    isBackPressed = false
                }
            }

            Spacer()

            Button {
                onSaveButtonTap()
            } label: {
                ZStack {
                    Image(systemName: "heart.circle.fill")
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .padding(5)
                        .foregroundColor(.cyan)
                        .opacity(isSavePressed ? 0.9 : 1)
                        .background(.gray.opacity(0.5))
                        .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 3)
                        .clipShape(Circle())
                        .scaleEffect(buttonScale)
                        .animation(.easeInOut, value: buttonScale)
                }
            }
            .overlay(
                Image(systemName: "heart.fill")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .foregroundColor(.red)
                    .opacity(isSavePressed ? 0.8 : 0)
                    .offset(y: -50)
                    .scaleEffect(heartScale)
                    .animation(.interpolatingSpring(stiffness: 100, damping: 10, initialVelocity: 5), value: heartScale)
            )
        }
        .padding()
        .padding(.bottom, 40)
    }
}


struct SongButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SongButtonsView(
            isPressed: .constant(false),
            isBackPressed: .constant(false),
            isSavePressed: .constant(false),
            showSavedConfirmation: .constant(false),
            heartScale: .constant(1.0),
            buttonScale: .constant(1.0),
            onSaveButtonTap: {},
            onBackButtonTap: {},
            onTabItButtonTap: {}
        )
    }
}

