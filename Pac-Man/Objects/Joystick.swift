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
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundStyle(.cyan)
                                .offset(y: geo.size.height * 0.01)
                        }
                    }
                
                
                
                // Joystick and Arrows
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        
                        Triangle()
                            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.1)
                        
                        Spacer()
                    }
                    
                    HStack(spacing: -geo.size.width * 0.055) {
                        Triangle()
                            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.1)
                            .rotationEffect(Angle(degrees: 270))
                        
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

                        Triangle()
                            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.1)
                            .rotationEffect(Angle(degrees: 90))
                    }
                    
                    HStack(spacing: 0) {
                        Spacer()
                        
                        Triangle()
                            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.1)
                            .rotationEffect(Angle(degrees: 180))
                        
                        Spacer()
                    }
                }
                .foregroundStyle(.red.opacity(0.9))
            }
            
        }
    }
}

#Preview {
    Joystick()
}
