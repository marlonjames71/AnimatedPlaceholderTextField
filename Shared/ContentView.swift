//
//  ContentView.swift
//  Shared
//
//  Created by Marlon Raskin on 9/14/21.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
//            AnimatedTextField()
            AnimatedTextField(icon: Image(systemName: "magnifyingglass"))
                .padding(.horizontal)
                .padding(.vertical, 100)
            Spacer()
        }
        .background(
            LinearGradient(
                colors: [.cyan, .indigo],
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
