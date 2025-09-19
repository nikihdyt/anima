//
//  Orb1.swift
//  anima
//
//  Created by Niki Hidayati on 14/09/25.
//

import SwiftUI

struct Orb1: View {
    @State private var dragAmount = CGSize.zero
    @State private var finalAmount = CGSize.zero
    let objectSize: CGSize = CGSize(width: 300, height: 300)
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let seconds = timeline.date.timeIntervalSince1970
                
            ZStack {
                // Background glow
                Circle()
                    .fill(RadialGradient(
                        colors: [.blue.opacity(0.2), .clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 60
                    ))
                    .scaleEffect(1.5)
                    
                // Core orb
                Circle()
                    .fill(RadialGradient(
                        colors: [
                            .white,
                            .cyan,
                            .blue.opacity(0.5),
                            .purple.opacity(0.2)
                        ],
                        center: UnitPoint(x: 0.3, y: 0.3),
                        startRadius: 0,
                        endRadius: 35
                    ))
                    .frame(width: 50, height: 50)
                    .scaleEffect(sin(seconds * 2) * 0.15 + 1.0)
                    
                // Floating particles
                ForEach(0..<12, id: \.self) { i in
                    Circle()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 2, height: 2)
                        .offset(
                            x: cos(seconds * 1.5 + Double(i) * 0.5) * 40,
                            y: sin(seconds * 1.2 + Double(i) * 0.7) * 35
                        )
                        .scaleEffect(sin(seconds * 3 + Double(i)) * 0.5 + 1)
                        .opacity(sin(seconds * 2 + Double(i) * 0.3) * 0.4 + 0.6)
                }
            }
            .frame(width: objectSize.width, height: objectSize.height)
            .clipShape(.circle)
            .shadow(color: .cyan, radius: 15, x: 0, y: 0)
        }
    }
}

#Preview {
    Orb1()
}
