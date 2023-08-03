//
//  WaveFormView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/10/23.
//

import SwiftUI

struct WaveFormView: View {
    @State private var phase = 0.0

    var body: some View {
        ZStack {
            ForEach(0..<25) { i in
                Wave(strength: 70, frequency: 15, phase: self.phase)
                    .stroke(Color.blue.opacity(Double(i) / 20), lineWidth: 5)
                    .offset(y: CGFloat(i) * 8)
            }
        }
        .frame(alignment: .top)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                self.phase = .pi * 2
            }
        }
    }
}

struct WaveFormView_Previews: PreviewProvider {
    static var previews: some View {
        WaveFormView()
    }
}
