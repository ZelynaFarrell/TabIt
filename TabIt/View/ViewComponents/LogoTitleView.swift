//
//  LogoTitleView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/27/23.
//

import SwiftUI

struct LogoTitleView: View {
    var body: some View {
        VStack {
            Image(systemName: "waveform.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .foregroundColor(.white) //font is white for loginviews background
                .padding(.bottom, 5)
            
            
            Text("Welcome to TabIt")
                .font(.custom("Caprasimo-Regular", size: 35))
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.5), radius: 5, x: 0, y: 5)
        }
    }
}

struct LogoTitleView_Previews: PreviewProvider {
    static var previews: some View {
        LogoTitleView()
    }
}
