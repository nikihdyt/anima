//
//  FlightTicketView.swift
//  anima
//
//  Created by Niki Hidayati on 17/09/25.
//

import SwiftUI

struct TicketShape: Shape {
    let circleRadius: CGFloat = 15
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        // Start from top left
        path.move(to: CGPoint(x: 0, y: 0))
        
        // Top edge
        path.addLine(to: CGPoint(x: width, y: 0))
        
        // Right edge to middle
        path.addLine(to: CGPoint(x: width, y: height * 0.7 - circleRadius))
        
        // Right semicircle cutout
        path.addArc(
            center: CGPoint(x: width, y: height * 0.7),
            radius: circleRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(90),
            clockwise: true
        )
        
        // Right edge from middle to bottom
        path.addLine(to: CGPoint(x: width, y: height))
        
        // Bottom edge
        path.addLine(to: CGPoint(x: 0, y: height))
        
        // Left edge to middle
        path.addLine(to: CGPoint(x: 0, y: height * 0.7 + circleRadius))
        
        // Left semicircle cutout
        path.addArc(
            center: CGPoint(x: 0, y: height * 0.7),
            radius: circleRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(-90),
            clockwise: true
        )
        
        // Left edge from middle to top
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        return path
    }
}

struct FlightTicketView: View {
    var body: some View {
        ZStack {
            // Custom ticket shape with cutouts
            TicketShape()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.9), Color.gray.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            // Rest of your content...
            VStack(spacing: 0) {
                // Main ticket content (sama kayak sebelumnya)
                VStack(spacing: 20) {
                    // Your existing code here...
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 32)
            }
        }
        .frame(width: 320, height: 520)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

struct ContentView2: View {
    var body: some View {
        FlightTicketView()
            .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView2()
}
