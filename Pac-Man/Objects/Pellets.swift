//
//  Pellets.swift
//  PacMan
//
//  Created by christian on 9/27/23.
//

import SwiftUI

struct Pellets: View {
    @State private var offset: CGFloat = 0.0
    @State private var isAnimating = false
    
    let circleSize: CGFloat = 50.0
    let circleSpacing: CGFloat = 70
    let circleCount = 100
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                
                HStack(spacing: circleSpacing) {
                    ForEach(0..<circleCount, id: \.self) { index in
                        Circle()
                            .fill(.white)
                            .frame(width: circleSize, height: circleSize)
                            .offset(x: offset)
                    }
                }
                
                Spacer()
            }
            .onAppear {
                withAnimation(.linear(duration: 20)) {
                    offset = -(geo.size.width + CGFloat(circleCount) * (circleSize + circleSpacing))
                }
                isAnimating = true
            }
        }
        
    }
}
#Preview {
    Pellets()
        .preferredColorScheme(.dark)
}
