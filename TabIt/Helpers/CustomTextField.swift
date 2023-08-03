//
//  CustomTextField.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/11/23.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    
    @State private var width = CGFloat.zero
    @State private var labelWidth = CGFloat.zero
    
    var body: some View {
        TextField(placeholder, text: $text)
            .foregroundColor(.white)
            .font(.system(size: 20))
            .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .trim(from: 0, to: 0.55)
                        .stroke(.gray, lineWidth: 2)
                    RoundedRectangle(cornerRadius: 5)
                        .trim(from: 0.565 + (0.44 * (labelWidth / width)), to: 1)
                        .stroke(.gray, lineWidth: 2)
                    Text(placeholder)
                        .foregroundColor(.white)
                        .overlay( GeometryReader { geo in Color.clear.onAppear { labelWidth = geo.size.width }})
                        .padding(2)
                        .font(.caption).bold()
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                        .offset(x: 20, y: -10)
                    
                }
            }
            .overlay( GeometryReader { geo in Color.clear.onAppear { width = geo.size.width }})
    }
}
