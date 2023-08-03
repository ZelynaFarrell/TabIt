//
//  ProcessingAnimationView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/10/23.
//

import SwiftUI

struct ProcessingAnimationView: View {
    @State private var isCircleAnimating = false

    let size: CGFloat
    let color: Color

    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<8) { index in
                    Circle()
                        .frame(width: size / 6, height: size / 6)
                        .foregroundColor(color)
                        .offset(y: -size / 2 + size / 12)
                        .rotationEffect(Angle(degrees: Double(index) * 45))
                        .opacity(0.5)
                        .rotationEffect(isCircleAnimating ? Angle(degrees: 360) : .zero)
                        .animation(Animation.linear(duration: 0.8).repeatCount(1, autoreverses: false).delay(0.1 * Double(index)), value: isCircleAnimating)
                }
            }
        }
        .frame(width: size, height: size)
        .onAppear {
            startAnimation()
        }
        .animation(.easeInOut(duration: 0.3), value: isCircleAnimating)
    }

    private func startAnimation() {
        animateCircles()
    }

    private func animateCircles() {
        withAnimation(Animation.linear(duration: 0.8)) {
            isCircleAnimating.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            animateCircles()
        }
    }
}



struct ProcessingAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessingAnimationView(size: 250, color: .blue)
    }
}
