//
//  MsPacMan.swift
//  Pac-Man
//
//  Created by christian on 9/29/23.
//

import SwiftUI

struct Lip: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            
        }
    }
}


struct MsPacMan: View {
    let scale: CGFloat
    
    @Binding var mouthOpen: Bool
    
    var body: some View {
        PacManShape(mouthAngle: mouthOpen ? 35 : 0)
            .frame(width: scale * 50, height: scale * 50)
            .foregroundStyle(.yellow)
    }
}

#Preview {
    MsPacMan(scale: 5, mouthOpen: .constant(true))
}
