//
//  PlaceholderCarouselView.swift
//  PlaceholderCaarouselView
//
//  Created by Marlon Raskin on 9/14/21.
//

import SwiftUI

struct PlaceholderCarouselView: View {

    // MARK: - Properties & State

    let placeholders: [String]

    @State private var currentIndex: Int = 0
    private let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()


    // MARK: - Init

    init(placeholders: [String]) {
        self.placeholders = placeholders
        currentIndex = randomStartIndex
    }


    // MARK: - Body

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("Search")

            ForEach(placeholderTuples, id: \.0) { (index, word) in
                if currentIndex % placeholders.count == index {
                    Text(word.quotedWord())
                        .transition(textTransition)
                }
            }

            Spacer()
        }
        .foregroundColor(.secondary)
        .tint(.secondary)
        .onAppear { currentIndex = randomStartIndex }
        .onReceive(timer) { _ in
            withAnimation { updateCurrentIndex() }
        }
    }


    // MARK: - Helper Methods

    var placeholderTuples: [(Int, String)] {
        Array(zip(placeholders.indices, placeholders))
    }

    var textTransition: AnyTransition {
        AnyTransition.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity),
                                 removal: .move(edge: .top).combined(with: .opacity))
    }

    var randomStartIndex: Int {
        Int.random(in: 0...placeholders.count)
    }

    func updateCurrentIndex() {
        if currentIndex == placeholders.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
}


// MARK: - Preview

struct PlaceholderCarouselView_Previews: PreviewProvider {
    static var previews: some View {

        PlaceholderCarouselView(placeholders: PlaceholderData.placeholderWords)
            .preferredColorScheme(.dark)
    }
}


// MARK: - Extensions

fileprivate extension String {
    func quotedWord() -> Self { "\"\(self)\"" }
}
