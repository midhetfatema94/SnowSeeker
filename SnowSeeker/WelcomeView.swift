//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Waveline Media on 1/24/21.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
