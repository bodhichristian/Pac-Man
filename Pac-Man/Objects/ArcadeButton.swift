//
//  ArcadeButton.swift
//  Pac-Man
//
//  Created by christian on 10/4/23.
//

import SwiftUI

struct ArcadeButton: View {
    @State private var pressed = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Outer ring
                Circle()
                    .stroke(lineWidth: geo.size.width * 0.1)
                
                // Button
 
                Button {
                    
                } label : {
                    ZStack {
                        Circle()
                            .padding(geo.size.width * 0.08)
                        
                        // Shading
                        Circle()
                            .padding(geo.size.width * 0.08)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.black, .clear, .clear],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [.white, .black]),
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: geo.size.width * 0.6
                                )
                            )
                            .padding(geo.size.width * 0.15)
                            .opacity(0.15)
                    }
                }
                .withArcadeButtonStyle()
                .onTapGesture {
                    pressed = true
                }

            }
            .foregroundStyle(.red)
            .padding(40)
        }
        
    }
}

#Preview {
    ArcadeButton()
}



struct ArcadeButtonStyle: ButtonStyle {
    
    let scaleAmount: CGFloat = 0.95
    
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .brightness(configuration.isPressed ? -0.05 : 0)
            
    }
}


extension View {

    func withArcadeButtonStyle() -> some View {
        // No need to notate `self` - system will handle
        buttonStyle(ArcadeButtonStyle())
    }
}


