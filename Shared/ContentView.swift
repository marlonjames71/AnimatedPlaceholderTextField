//
//  ContentView.swift
//  Shared
//
//  Created by Marlon Raskin on 9/14/21.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        ZStack {
            LinearGradient(colors: [.cyan, .indigo], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            PlaceholderCarouselView(placeholderWords: PlaceholderData.placeholderWords)
                .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
