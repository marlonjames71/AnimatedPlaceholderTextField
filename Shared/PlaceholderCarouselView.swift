//
//  PlaceholderCarouselView.swift
//  PlaceholderCaarouselView
//
//  Created by Marlon Raskin on 9/14/21.
//

import SwiftUI

struct PlaceholderCarouselView: View {

    let placeholderWords: [String]

    @State private var degrees = 0.0
    @State private var currentIndex: Int = 0
    @State private var showPlaceholderAtEvenIndex: Bool = true

    let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()


    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("Search")

            Group {
                if placeholderIsAtEvenIndex { Text(placeholderText) }
                if !placeholderIsAtEvenIndex { Text(placeholderText) }
            }
            .transition(.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity),
                                    removal: .move(edge: .top).combined(with: .opacity)))

            Spacer()
        }
        .foregroundColor(.secondary)
        .tint(.secondary)
        .padding()
        .onReceive(timer) { _ in
            withAnimation {
                updateCurrentIndex()
                showPlaceholderAtEvenIndex.toggle()
            }
        }
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        .padding(.horizontal)
    }


    var placeholderText: String {
        let placeholderText: String
        switch placeholderIsAtEvenIndex {
        case true:
            placeholderText = showPlaceholderAtEvenIndex ? placeholder() : previousPlaceholder()
        case false:
            placeholderText = showPlaceholderAtEvenIndex ? previousPlaceholder() : placeholder()
        }

        return placeholderText.quotedWord()
    }

    func placeholder() -> String {
        placeholderWords[currentIndex]
    }

    func previousPlaceholder() -> String {
        if currentIndex == 0 {
            return placeholderWords.last ?? ""
        } else {
            return placeholderWords[currentIndex - 1]
        }
    }

    var placeholderIsAtEvenIndex: Bool {
        currentIndex.isMultiple(of: 2)
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
