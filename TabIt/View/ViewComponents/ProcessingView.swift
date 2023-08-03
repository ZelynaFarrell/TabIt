//
//  ProcessingView.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/26/23.
//

import SwiftUI

struct ProcessingView: View {
    var body: some View {
        VStack(spacing: 10) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Text("Loading...")
                .foregroundColor(.blue)
        }
    }
}
struct ProcessingView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessingView()
    }
}
