//
//  GameView.swift
//  PacMan
//
//  Created by christian on 9/27/23.
//

import SwiftUI

struct GameView: View {
    
    
    let scale = 1.5
    
    @State private var isPlaying = false
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
        GeometryReader { geo in
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    PacMan(scale: scale, mouthOpen: $isPlaying)
                    
                    Spacer()
                    
                    Joystick(scale: scale * 0.8, direction: $direction)
                        .padding(.bottom, 40)
                }

            }
            
        }
    }
}

#Preview {
    GameView()
}





