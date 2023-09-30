//
//  CharacterDisplay.swift
//  PacMan
//
//  Created by christian on 9/28/23.
//

import SwiftUI

struct CharacterDisplay: View {
    let scale = 1.2
    
    @State private var direction: Direction = .none
    
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
        NavigationStack {
            VStack(spacing: 40) {
      
                
                PacMan(scale: 3, mouthOpen: .constant(true))
                    .rotationEffect(Angle(degrees: rotationDegree))
                
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
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.thinMaterial)
                }

                Joystick(scale: 1.3, direction: $direction)
                
            }
            .background {
                Color.black
        }
            .navigationTitle("Pac-Man")
        }
    }
}

#Preview {
    CharacterDisplay()
        .preferredColorScheme(.dark)
}





