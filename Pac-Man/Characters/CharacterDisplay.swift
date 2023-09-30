//
//  CharacterDisplay.swift
//  PacMan
//
//  Created by christian on 9/28/23.
//

import SwiftUI

struct CharacterDisplay: View {
    let scale = 1.5
    
    var body: some View {
        VStack {
            Text("Pac-Man")
                .font(.title)
                .bold()
            
            PacMan(scale: 4, mouthOpen: .constant(true))
            
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
                    .foregroundStyle(.ultraThinMaterial)
            }
            .padding(.top, 20)
            
            Joystick()
            
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





