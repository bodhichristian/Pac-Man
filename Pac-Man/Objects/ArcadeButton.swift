//
//  ArcadeButton.swift
//  Pac-Man
//
//  Created by christian on 10/4/23.
//

import SwiftUI

struct ArcadeButton: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .stroke(lineWidth: geo.size.width * 0.1)
                Circle()
                    .padding(geo.size.width * 0.08)
                    
                Circle()
                    .padding(geo.size.width * 0.08)
                    .foregroundStyle(LinearGradient(colors: [.black, .clear, .clear], startPoint: .topLeading, endPoint: .bottomTrailing))

            }
            .foregroundStyle(.red)
            .padding()
        }
        
    }
}

#Preview {
    ArcadeButton()
}
