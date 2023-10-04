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
                    Joystick(scale: scale * 0.8, direction: $direction)
                        .padding(.bottom, 40)
                        .onChange(of: direction) { oldValue, newValue in
                            withAnimation(.linear){
                                movePacMan(in: geo)
                            }
                            if oldValue == .none {
                                withAnimation(.easeInOut(duration: 0.15).repeatForever()) {
                                    mouthOpen.toggle()
                                }
                            }
                        }
                }
            }
        }
    }
    
    private func movePacMan(in geo: GeometryProxy) {
        
        if direction == .up  {
            pacManYOffset = -geo.size.width / 2
        } else if direction == .down {
            pacManYOffset =  geo.size.width / 2
        } else if direction == .left {
            pacManXOffset = -geo.size.width / 2
        } else if direction == .right {
            pacManXOffset = geo.size.width / 2
        }
    }
    
}

#Preview {
    GameView()
}





