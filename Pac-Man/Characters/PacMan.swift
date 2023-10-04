//
//  PacMan.swift
//  PacMan
//
//  Created by christian on 9/27/23.
//

import SwiftUI

struct PacManShape: Shape {
    var mouthAngle: Double
    
    var animatableData: Double {
        get { mouthAngle }
        set { mouthAngle = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX * 0.4, y: rect.midY))
            
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: mouthAngle),
                endAngle: Angle(degrees: 360 - mouthAngle),
                clockwise: false)
        }
    }
}

struct PacMan: View {
    let scale: CGFloat
    
    @Binding var mouthOpen: Bool
    
    var body: some View {
        PacManShape(mouthAngle: mouthOpen ? 45 : 0)
            .frame(width: scale * 50, height: scale * 50)
            .foregroundStyle(.yellow)
    }
}

#Preview {
    PacMan(scale: 5, mouthOpen: .constant(true))
}
