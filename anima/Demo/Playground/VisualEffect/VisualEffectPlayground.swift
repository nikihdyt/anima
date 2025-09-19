//
//  VisualEffectPlayground.swift
//  anima
//
//  Created by Niki Hidayati on 17/09/25.
//

import SwiftUI

struct VisualEffectPlayground: View {
    let colors: [Color] = [.red, .blue, .green, .orange, .purple, .pink, .yellow, .cyan]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(0..<20, id: \.self) { index in
                        CardView(
                            title: "Card \(index + 1)",
                            color: colors[index % colors.count]
                        )
                        .visualEffect { content, proxy in
                            content
                            
                                .scaleEffect(getScale(proxy: proxy))
                                .opacity(getOpacity(proxy: proxy))
                                .rotation3DEffect(
                                    .degrees(getRotation(proxy: proxy)),
                                    axis: (x: 1, y: 0, z: 0)
                                )
                                .blur(radius: getBlurRadius(proxy: proxy))
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Scroll Effects")
        }

    }
    
    // MARK: - Visual Effect Functions
       
       /// Scale effect based on distance from center
       private func getScale(proxy: GeometryProxy) -> Double {
           let frame = proxy.frame(in: .global)
           let screenHeight = UIScreen.main.bounds.height
           let midY = screenHeight / 2
           
           // Distance from center of screen
           let distance = abs(frame.midY - midY)
           
           // Scale from 1.0 (center) to 0.7 (edges)
           let maxDistance = screenHeight / 2
           let scale = max(0.7, 1.0 - (distance / maxDistance) * 0.3)
           
           return scale
       }
       
       /// Opacity effect - fade cards that are far from center
       private func getOpacity(proxy: GeometryProxy) -> Double {
           let frame = proxy.frame(in: .global)
           let screenHeight = UIScreen.main.bounds.height
           let midY = screenHeight / 2
           
           let distance = abs(frame.midY - midY)
           let maxDistance = screenHeight / 2
           
           // Opacity from 1.0 (center) to 0.3 (edges)
           let opacity = max(0.3, 1.0 - (distance / maxDistance) * 0.7)
           
           return opacity
       }
       
       /// 3D rotation effect
       private func getRotation(proxy: GeometryProxy) -> Double {
           let frame = proxy.frame(in: .global)
           let screenHeight = UIScreen.main.bounds.height
           let midY = screenHeight / 2
           
           // Rotate based on position relative to center
           let offset = frame.midY - midY
           let rotation = offset / 10 // Adjust divisor for more/less rotation
           
           return rotation
       }
       
       /// Blur effect for cards at edges
       private func getBlurRadius(proxy: GeometryProxy) -> Double {
           let frame = proxy.frame(in: .global)
           let screenHeight = UIScreen.main.bounds.height
           let midY = screenHeight / 2
           
           let distance = abs(frame.midY - midY)
           let maxDistance = screenHeight / 3
           
           // Blur increases with distance from center
           let blurRadius = min(5.0, max(0, (distance - maxDistance / 2) / 50))
           
           return blurRadius
       }
}

// MARK: - Card View
struct CardView: View {
    let title: String
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(
                    colors: [color.opacity(0.8), color.opacity(0.4)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(height: 120)
            .overlay {
                VStack {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Scroll to see effects")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    VisualEffectPlayground()
}
