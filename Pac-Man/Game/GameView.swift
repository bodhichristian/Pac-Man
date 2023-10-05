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
                        Joystick(scale: scale * 0.8, direction: $direction)
                          
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
                        Spacer()
                        VStack(spacing: -10) {
                            Text("Start")
                                .fontDesign(.monospaced)
                                .font(.title2).bold()
                                .foregroundStyle(.red)
                            
                            ArcadeButton(color: .red, scale: scale * 0.7) {
                                startGame()
                            }
                            .padding(.bottom)
                            
                            Text("Reset")
                                .fontDesign(.monospaced)
                                .font(.title2).bold()
                                .foregroundStyle(.white)
                            
                            ArcadeButton(color: .white, scale: scale * 0.7) {
                                reset()
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    private func startGame() -> () {
        direction = .right
        // this will notify onChange(of: direction)
        // to call movePacMan(in geo:)
    }
    
    private func reset() {
        direction = .none
        mouthOpen = false
        pacManXOffset = 0
        pacManYOffset = 0
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





