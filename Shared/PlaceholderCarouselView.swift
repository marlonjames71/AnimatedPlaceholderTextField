//
//  PlaceholderCarouselView.swift
//  PlaceholderCaarouselView
//
//  Created by Marlon Raskin on 9/14/21.
//

import SwiftUI

struct PlaceholderCarouselView: View {

    let placeholderWords: [String]

    @State private var currentIndex: Int = 0
    let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()


    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("Search")

            ForEach(placeholderTuples, id: \.0) { (index, word) in
                if currentIndex % placeholderWords.count == index {
                    Text(word.quotedWord())
                        .transition(textTransition)
                }
            }

            Spacer()
        }
        .foregroundColor(.secondary)
        .tint(.secondary)
        .padding()
        .onReceive(timer) { _ in
            withAnimation { updateCurrentIndex() }
        }
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
    }


    var placeholderTuples: [(Int, String)] {
        Array(zip(placeholderWords.indices, placeholderWords))
    }

    var textTransition: AnyTransition {
        AnyTransition.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity),
                                 removal: .move(edge: .top).combined(with: .opacity))
    }

    func updateCurrentIndex() {
        if currentIndex == placeholderWords.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
}


struct PlaceholderCarouselView_Previews: PreviewProvider {
    static var previews: some View {

        PlaceholderCarouselView(placeholderWords: PlaceholderData.placeholderWords)
            .preferredColorScheme(.dark)
    }
}


fileprivate extension String {
    func quotedWord() -> Self { "\"\(self)\"" }
}
