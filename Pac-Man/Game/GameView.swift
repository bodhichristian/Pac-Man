//
//  GameView.swift
//  PacMan
//
//  Created by christian on 9/27/23.
//

import SwiftUI

struct GameView: View {
    @State private var isPlaying = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                
                if isPlaying {
                    HStack {
                        Spacer()
                        Pellets()
                            .clipShape(.rect)
                            .frame(width: geo.size.width * 0.6)
                    }
                }
                
                PacMan(scale: 5, mouthOpen: $isPlaying)

                VStack {
                    Spacer()
                    Button {
                        if !isPlaying {
                            withAnimation(.easeInOut(duration: 0.2).repeatForever()) {
                                isPlaying.toggle()
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.2)){
                                isPlaying = false
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: "play.fill")
                            Image(systemName: "pause")
                        }
                        .defaultButtonFormatting()
                    }
                    .withPressableStyle()
                    .padding()
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    GameView()
}





