//
//  Ghost.swift
//  PacMan
//
//  Created by christian on 9/28/23.
//

import SwiftUI

// 2D Ghost Shape Base Layer
struct GhostShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            // Set starting position
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            // MARK: Base curves
            // Curve 1 - up
            path.addQuadCurve(
                to: CGPoint(x: rect.width * 0.22, y: rect.maxY),
                control: CGPoint(
                    x: rect.width * 0.15,
                    y: rect.height * 0.9
                )
            )
            // Curve 2 - down
            path.addQuadCurve(
                to: CGPoint(x: rect.width * 0.4, y: rect.maxY),
                control: CGPoint(
                    x: rect.width * 0.3,
                    y: rect.height * 1.10
                )
            )
            // Curve 3 - up
            path.addQuadCurve(
                to: CGPoint(x: rect.width * 0.6, y: rect.maxY),
                control: CGPoint(
                    x: rect.width * 0.5,
                    y: rect.height * 0.9
                )
            )
            // Curve 4 - down
            path.addQuadCurve(
                to: CGPoint(x: rect.width * 0.8, y: rect.maxY),
                control: CGPoint(
                    x: rect.width * 0.7,
                    y: rect.height * 1.10
                )
            )
            // Curve 5 - up
            path.addQuadCurve(
                to: CGPoint(x: rect.maxY, y: rect.maxY),
                control: CGPoint(
                    x: rect.width * 0.87,
                    y: rect.height * 0.9
                )
            )
            
            // MARK: Rectangular base
            // Create a rectanglular path to starting position
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            // MARK: Semi-cirlcle top
            // Add arc to top of ghost shape
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: rect.height / 2,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 180),
                        clockwise: true)
        }
    }
}

struct Eyes: View {
    let direction: Direction
    
    // Switch on direction
    // to provide a pupil alignment in the body
    var alignment: Alignment {
        switch direction {
        case .left:
                .leading
        case .right:
                .trailing
        case .up:
                .top
        case .down:
                .bottom
        case .none:
                .center
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: geo.size.width * 0.1) {
                Spacer()
                // Left eye
                ZStack(alignment: alignment) {
                    // Eyeball
                    Capsule()
                        .frame(
                            width: geo.size.width * 0.25,
                            height: geo.size.width * 0.35
                        )
                        .foregroundStyle(.white)
                    
                    // Pupil
                    Circle()
                        .frame(width: geo.size.width * 0.18)
                        .foregroundStyle(.blue)
                }
                
                // Right eye
                ZStack(alignment: alignment) {
                    // Eyeball
                    Capsule()
                        .frame(
                            width: geo.size.width * 0.25,
                            height: geo.size.width * 0.35
                        )
                        .foregroundStyle(.white)
                    
                    // Pupil
                    Circle()
                        .frame(width: geo.size.width * 0.18)
                        .foregroundStyle(.blue)
                }
                Spacer()
            }
            .offset(x: 0, y: geo.size.height * 0.2)
        }
    }
}

enum Character {
    case blinky, pinky, inky, clyde
}

struct Ghost: View {
    let character: Character
    let eyeDirection: Direction
    let scale: CGFloat
    
    var ghostColor: Color {
        switch character {
        case .blinky:
            return .red
        case .pinky:
            return .pink.opacity(0.4)
        case .inky:
            return .mint.opacity(0.4)
        case .clyde:
            return .orange.opacity(0.8)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Pinky, Inky, and Clyde receive
                // a white base layer behind main ghost
                if character != .blinky {
                    GhostShape()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .foregroundStyle(.white)
                }
                
                // Main ghost object
                GhostShape()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .foregroundStyle(ghostColor)
                
                Eyes(direction: eyeDirection)
                    .offset(y: geo.size.height * 0.16)
            }
        }
        .frame(width: scale * 50, height: scale * 50)
    }
}

#Preview {
    Ghost(character: .blinky, eyeDirection: .up, scale: 2)
}
