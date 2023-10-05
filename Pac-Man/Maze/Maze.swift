//
//  Maze.swift
//  Pac-Man
//
//  Created by christian on 10/5/23.
//

import SwiftUI

struct Maze: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX / 10 * 2, y: rect.midY + 80) )
            path.addLine(to: CGPoint(x: rect.maxX / 10 * 2, y: rect.midY - 10))
        }
    }
}


struct MazeView: View {
    var body: some View {
        GeometryReader { geo in
            Maze()
                .stroke(.cyan, lineWidth: 4)
                .frame(width: geo.size.width, height: geo.size.width)
            
        }
    }
}

#Preview {
    MazeView()
}
