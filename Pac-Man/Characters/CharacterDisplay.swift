//
//  CharacterDisplay.swift
//  PacMan
//
//  Created by christian on 9/28/23.
//

import SwiftUI

struct CharacterDisplay: View {
    let scale = 1.5
    
    @State private var direction: Direction = .none
    
    // Return an rotation amount for Pac-Man
    private var rotationDegree: Double {
        switch direction {
        case .left:
            180
        case .right:
            0
        case .up:
            90
        case .down:
            270
        case .none:
            0
        }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            PacMan(scale: 4, mouthOpen: .constant(true))
                .rotationEffect(Angle(degrees: rotationDegree))
            
            // Ghosts
            HStack {
                VStack {
                    Ghost(character: .blinky, eyeDirection: .down, scale: scale)
                    Text("Blinky")
                }
                
                VStack {
                    Ghost(character: .pinky, eyeDirection: .up, scale: scale)
                    Text("Pinky")
                }
                
                VStack {
                    Ghost(character: .inky, eyeDirection: .left, scale: scale)
                    Text("Inky")
                }
                
                VStack {
                    Ghost(character: .clyde, eyeDirection: .right, scale: scale)
                    Text("Clyde")
                }
            }
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.thinMaterial)
            }
            
            Joystick(scale: 1.3, direction: $direction)
            
        }
        .background {
            Color.black
        }
        
    }
}

#Preview {
    CharacterDisplay()
        .preferredColorScheme(.dark)
}









