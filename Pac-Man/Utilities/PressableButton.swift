//
//  PressableButton.swift
//  PacMan
//
//  Created by christian on 9/27/23.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity - 20)
            .background(color)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}

extension View {
    func defaultButtonFormatting(color: Color = .blue) -> some View {
        self
            .modifier(DefaultButtonViewModifier(color: color))
    }
}

struct PressableButton: ButtonStyle {
    
    let scaleAmount: CGFloat
    
    init(scaleAmount: CGFloat) {
        self.scaleAmount = scaleAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

extension View {

    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        // No need to notate `self` - system will handle
        buttonStyle(PressableButton(scaleAmount: scaledAmount))
    }
}

struct ButtonStyles: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Click Me")
                .defaultButtonFormatting(color: .purple)
        }
        .withPressableStyle()
        .padding(40)
    }
}

#Preview {
    ButtonStyles()
}








