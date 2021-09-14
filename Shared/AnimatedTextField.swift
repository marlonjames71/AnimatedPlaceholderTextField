//
//  AnimatedTextField.swift
//  AnimatedTextField
//
//  Created by Marlon Raskin on 9/14/21.
//

import SwiftUI

struct AnimatedTextField: View {

    // MARK: - Properties & State

    enum Field: Hashable {
        case searchField
    }

    let icon: Image?

    @State private var textInput: String = ""
    @FocusState private var focusedField: Field?


    // MARK: - Init

    init(icon: Image? = nil) {
        self.icon = icon
    }


    // MARK: - Body

    var body: some View {
        ZStack {
            HStack {
                if let icon = icon {
                    icon.foregroundColor(.secondary)
                }

                ZStack {
                    if focusedField == .searchField && textInput.isEmpty {
                        PlaceholderCarouselView(placeholders: PlaceholderData.placeholderWords)
                            .allowsHitTesting(false)
                            .animation(!textInput.isEmpty ? nil : .linear, value: textInput)
                    }

                    HStack {
                        TextField(defaultTextPrompt, text: $textInput.animation(sprintAnimation)) { isEditing in
                            focusedField = isEditing ? .searchField : nil
                        }
                        .accentColor(.cyan)
                        .tint(.secondary)
                        .focused($focusedField, equals: .searchField)

                        Spacer()

                        if !textInput.isEmpty && focusedField == .searchField {
                            Button(action: clearText) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                                    .tint(.secondary)
                            }
                            .frame(width: 22, height: 22)
                            .animation(.default, value: textInput)
                            .transition(iconTransition(edge: .trailing).combined(with: .opacity))
                        }
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
        .frame(maxHeight: 60)
    }


    // MARK: - Helper Methods

    func clearText() {
        withAnimation(sprintAnimation.delay(0.15)) {
            textInput = ""
        }
    }

    var defaultTextPrompt: String {
        focusedField == nil ? "Search" : ""
    }

    private func iconTransition(edge: Edge) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: edge).combined(with: .opacity),
            removal: .move(edge: edge).combined(with: .opacity))
    }

    private var sprintAnimation: Animation {
        .spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.0)
    }
}


// MARK: - Preview

struct AnimatedTextField_Previews: PreviewProvider {
    static var previews: some View {
//        AnimatedTextField()
        AnimatedTextField(icon: Image(systemName: "magnifyingglass"))
            .preferredColorScheme(.dark)
    }
}
