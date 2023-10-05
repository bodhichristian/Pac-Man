//
//  GameView.swift
//  PacMan
//
//  Created by christian on 9/27/23.
//

import SwiftUI

struct GameView: View {
    
    
    let scale = 1.5
    
    @State private var mouthOpen = false
    @State private var direction: Direction = .none
    
    @State private var pacManXOffset: CGFloat = .zero
    @State private var pacManYOffset: CGFloat = .zero
    
    @State private var gameStarted = false
    @State private var resetPressed = false
    
    // Return an rotation amount for Pac-Man
    private var rotationDegree: Double {
        switch direction {
        case .left:
            180
        case .right:
            0
        case .up:
            270
        case .down:
            90
        case .none:
            0
        }
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    Spacer()
                    
                    PacMan(scale: scale, mouthOpen: $mouthOpen)
                        .frame(width: geo.size.width, height: geo.size.width)
                        .rotationEffect(Angle(degrees: rotationDegree))
                        .offset(x: pacManXOffset * 0.8, y: pacManYOffset * 0.8)
                    
                    Spacer()
                    
                    HStack {
                        ArcadeButton(color: .red, scale: scale * 0.7, pressed: $gameStarted) {
                            startGame()
                        }
                        
                    }
                    
                    
                    
                    Joystick(scale: scale * 0.8, direction: $direction)
                        .padding(.bottom, 40)
                        .onChange(of: direction) { oldValue, newValue in
                            withAnimation(.linear){
                                movePacMan(in: geo)
                            }
                            if oldValue == .none {
                                withAnimation(.linear(duration: 0.15).repeatForever()) {
                                    mouthOpen.toggle()
                                }
                            }
                        }
                    
                    
                }
            }
        }
    }
    
    private func startGame() -> () {
        direction = .right
        print(direction)
        
    }
    
    private func movePacMan(in geo: GeometryProxy) {
        switch direction {
        case .left:
            pacManXOffset = -geo.size.width / 2
        case .right:
            pacManXOffset =  geo.size.width / 2
        case .up:
            pacManYOffset = -geo.size.width / 2
        case .down:
            pacManYOffset = geo.size.width / 2
        case .none:
            return
        }
        
        
    }
    
}

#Preview {
    GameView()
}





