//
//  JoyStick.swift
//  Pac-Man
//
//  Created by christian on 9/29/23.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY * 0.25))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct JoystickBorder: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            // MARK: Outer border
            path.move(to: CGPoint(x: rect.maxX * 0.33, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX * 0.33, y: rect.maxY))
            
            path.move(to: CGPoint(x: rect.maxX * 0.66, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX * 0.66, y: rect.minY))
            
            
            // MARK: Inner border
            path.move(to: CGPoint(x: rect.maxX * 0.33, y: rect.maxY * 0.05))
            path.addLine(to: CGPoint(x: rect.maxX * 0.05, y: rect.maxY * 0.05))
            
            path.addLine(to: CGPoint(x: rect.maxX * 0.05, y: rect.maxY * 0.95))
            path.addLine(to: CGPoint(x: rect.maxX * 0.33, y: rect.maxY * 0.95))
            
            path.move(to: CGPoint(x: rect.maxX * 0.66, y: rect.maxY * 0.95))
            path.addLine(to: CGPoint(x: rect.maxX * 0.95, y: rect.maxY * 0.95))
            
            path.addLine(to: CGPoint(x: rect.maxX * 0.95, y: rect.maxY * 0.05))
            path.addLine(to: CGPoint(x: rect.maxX * 0.66, y: rect.maxY * 0.05))
        }
    }
}

struct Joystick: View {
    let scale: CGFloat = 1.0
    let movementRadius: CGFloat = 50.0

    @State private var dragAmount = CGSize.zero
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                JoystickBorder()
                    .stroke(.cyan, lineWidth: 4)
                    .frame(width: geo.size.width, height: geo.size.width)
                    .overlay {
                        VStack {
                            Spacer()
                            Text("MOVE")
                                .font(.system(size: geo.size.width * 0.08))
                                .fontWeight(.black)
                                .foregroundStyle(.cyan)
                                .offset(y: geo.size.height * 0.01)
                        }
                    }

                // Joystick and Arrows
                ZStack {
                    // Up and down arrowts
                    VStack {
                        Triangle()
                            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.1)
                        
                        Spacer()
                        
                        Triangle()
                            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.1)
                            .rotationEffect(Angle(degrees: 180))
                    }
                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.45)
                    
                    // Left and right arrows
                    HStack(spacing: -geo.size.width * 0.055) {
                        Triangle()
                            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.1)
                            .rotationEffect(Angle(degrees: 270))
                        
                        Spacer()
                        
                        Triangle()
                            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.1)
                            .rotationEffect(Angle(degrees: 90))
                    }
                    
                    Circle()
                        .foregroundStyle(Color(white: 0.2))
                        .frame(width: geo.size.width * 0.58)
                    
                    // Joystick
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.white, .red, .black]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .padding()
                            .frame(width: geo.size.width * 0.5)
                        
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [Color.white, Color.black]),
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: geo.size.width * 0.25
                                )
                            )
                            .padding()
                            .frame(width: geo.size.width * 0.5)
                            .opacity(0.2)
                    }
                    .shadow(color: .black, radius: 8)
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let translation = gesture.translation
                                let distance = sqrt(pow(translation.width, 2) + pow(translation.height, 2))
                                
                                // Check if the distance is within the fixed radius
                                if distance <= geo.size.width * 0.15 {
                                    dragAmount = translation
                                } else {
                                    // If the distance exceeds the fixed radius, limit the movement
                                    let angle = atan2(translation.height, translation.width)
                                    let x = geo.size.width * 0.15 * cos(angle)
                                    let y = geo.size.width * 0.15 * sin(angle)
                                    dragAmount = CGSize(width: x, height: y)
                                }
                            }
                            .onEnded { _ in
                                dragAmount = .zero
                            }
                    )
                    .animation(.bouncy(), value: dragAmount)
                    
                }
                .foregroundStyle(.red.opacity(0.9))
            }
            .padding(5)
            
        }
        .frame(width: scale * 200, height: scale * 400)
    }
}

#Preview {
    Joystick()
}
