//
//  ArcadeButton.swift
//  Pac-Man
//
//  Created by christian on 10/4/23.
//

import SwiftUI

struct ArcadeButton: View {
    let color: Color
    let scale: Double
    
    let action: () -> ()
    
    @State private var pressed = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Outer ring
                Circle()
                    .stroke(lineWidth: geo.size.width * 0.05)
                    .overlay {
                        LinearGradient(
                            colors: [.clear, .clear, .black.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .padding(-10)
                        .opacity(pressed ? 0 : 1)
                    }
                
                // Button
                Button {
                    pressed = true
                    action()
                } label : {
                    ZStack {
                        Circle()
                            .padding(geo.size.width * 0.05)
                        
                        // Shading
                        Circle()
                            .padding(geo.size.width * 0.04)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.black.opacity(0.3), .clear, .clear],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .padding(geo.size.width * 0.08)
                        
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [.white, .black]),
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: geo.size.width * 0.6
                                )
                            )
                            .padding(geo.size.width * 0.12)
                            .opacity(0.15)
                    }
                }
                .withArcadeButtonStyle()
                
            }
            .foregroundStyle(color)
            .position(CGPoint(x: geo.size.width / 2, y: geo.size.height / 2))
            
        }
        .padding()
        .frame(width: scale * 100, height: scale * 100)
    }
}

#Preview {
    VStack {
        ArcadeButton(color: .white, scale: 2.0) {
            // action closure
        }
        ArcadeButton(color: .blue, scale: 2.0) {
            // action closure
        }
        ArcadeButton(color: .mint, scale: 2.0) {
            // action closure
        }

    }
}

struct ArcadeButtonStyle: ButtonStyle {
    let scaleAmount: CGFloat = 0.97
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .brightness(configuration.isPressed ? -0.04 : 0)
        
    }
}

extension View {
    func withArcadeButtonStyle() -> some View {
        // No need to notate `self` - system will handle
        buttonStyle(ArcadeButtonStyle())
    }
}







