//
//  GradientBackground.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/27/23.
//

import SwiftUI

//struct GradientBackground: ViewModifier {
//    func body(content: Content) -> some View {
//        LinearGradient(
//            gradient: Gradient(stops: [
//                .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), location: 0),
//                .init(color: Color(#colorLiteral(red: 0.04435866326, green: 0.044916749, blue: 0.04490687698, alpha: 1)), location: 0.2),
//                .init(color: Color(#colorLiteral(red: 0.1066348031, green: 0.1066348031, blue: 0.1066348031, alpha: 1)), location: 0.4),
//                .init(color: Color(#colorLiteral(red: 0.1790125966, green: 0.1790125966, blue: 0.1790125966, alpha: 1)), location: 0.6),
//                .init(color: Color(#colorLiteral(red: 0.2154406905, green: 0.2181524038, blue: 0.2181046307, alpha: 1)), location: 0.8),
//                .init(color: Color(#colorLiteral(red: 0.239187777, green: 0.239187777, blue: 0.239187777, alpha: 1)), location: 1)
//            ]),
//            startPoint: .top,
//            endPoint: .bottom
//        )
//        .ignoresSafeArea()
//        .overlay(content)
//    }
//}

struct GradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.0338697608, green: 0.0343930539, blue: 0.03438401985, alpha: 1)), location: 0.15), // Adjusted location and color
                .init(color: Color(#colorLiteral(red: 0.08046954855, green: 0.08046954855, blue: 0.08046954855, alpha: 1)), location: 0.35), // Adjusted location and color
                .init(color: Color(#colorLiteral(red: 0.1396151876, green: 0.1396151876, blue: 0.1396151876, alpha: 1)), location: 0.5),  // Adjusted location and color
                .init(color: Color(#colorLiteral(red: 0.175726871, green: 0.1784142923, blue: 0.1783666319, alpha: 1)), location: 0.65), // Adjusted location and color
                .init(color: Color(#colorLiteral(red: 0.2013891109, green: 0.2013891109, blue: 0.2013891109, alpha: 1)), location: 0.8),  // Adjusted location and color
                .init(color: Color(#colorLiteral(red: 0.2013891109, green: 0.2013891109, blue: 0.2013891109, alpha: 1)), location: 1)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        .overlay(content)
    }
}
