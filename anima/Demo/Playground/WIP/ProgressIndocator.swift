import SwiftUI

struct ProgressIndocator: View {
    @State private var progress: Double = 0.0
    @State private var isAutoAnimating = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                // 1. Bouncy Circular Progress
                BouncyCircularProgress(progress: progress)
                
                // 5. Glowing Ring
                GlowingRing(progress: progress)
                
                // 6. Elastic Line Progress
                ElasticLineProgress(progress: progress)
                
                // 7. Particle System
                ParticleProgress(progress: progress)
                
                // Control Panel
                VStack(spacing: 20) {
                    Text("Progress: \(Int(progress * 100))%")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Slider(value: $progress, in: 0...1)
                        .tint(.purple)
                        .padding(.horizontal)
                    
                    Button(isAutoAnimating ? "Stop Auto Demo" : "Start Auto Demo") {
                        isAutoAnimating.toggle()
                        if isAutoAnimating {
                            startAutoAnimation()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
                }
                .padding(20)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
            }
            .padding()
        }
    }
    
    private func startAutoAnimation() {
        guard isAutoAnimating else { return }
        
        withAnimation(.easeInOut(duration: 2)) {
            progress = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            guard isAutoAnimating else { return }
            withAnimation(.easeInOut(duration: 2)) {
                progress = 0.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                startAutoAnimation()
            }
        }
    }
}

// 1. Bouncy Circular Progress dengan Spring Physics
struct BouncyCircularProgress: View {
    let progress: Double
    @State private var bounceScale = 1.0
    @State private var rotationAngle = 0.0
    
    var body: some View {
        VStack {
            Text("🏀 Bouncy Ring")
                .font(.headline)
                .fontWeight(.semibold)
            
            ZStack {
                // Outer glow ring
                Circle()
                    .stroke(Color.purple.opacity(0.2), lineWidth: 20)
                    .frame(width: 140, height: 140)
                    .blur(radius: 10)
                    .scaleEffect(bounceScale)
                
                // Main progress ring
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        AngularGradient(
                            colors: [.purple, .pink, .orange, .yellow, .purple],
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: 12, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90 + rotationAngle))
                    .scaleEffect(bounceScale)
                    .animation(.interpolatingSpring(stiffness: 200, damping: 10), value: progress)
                
                // Center emoji that reacts to progress
                Text(progress > 0.8 ? "🔥" : progress > 0.5 ? "⚡️" : progress > 0.2 ? "💫" : "⭐️")
                    .font(.system(size: 40))
                    .scaleEffect(1 + progress * 0.5)
                    .rotationEffect(.degrees(progress * 360))
                    .animation(.interpolatingSpring(stiffness: 300, damping: 8), value: progress)
            }
            .onChange(of: progress) { _, newValue in
                // Bounce effect when progress changes significantly
                withAnimation(.interpolatingSpring(stiffness: 400, damping: 6)) {
                    bounceScale = 1.1
                    rotationAngle += 10
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.interpolatingSpring(stiffness: 300, damping: 10)) {
                        bounceScale = 1.0
                    }
                }
            }
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

// 5. Glowing Ring dengan Particle Effect
struct GlowingRing: View {
    let progress: Double
    @State private var particleOffset = 0.0
    @State private var glowIntensity = 0.5
    
    var body: some View {
        VStack {
            Text("✨ Mystic Ring")
                .font(.headline)
                .fontWeight(.semibold)
            
            ZStack {
                // Multiple glow layers
                ForEach(0..<3) { index in
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.purple.opacity(0.3 - Double(index) * 0.1), lineWidth: CGFloat(20 - index * 5))
                        .frame(width: 120 + CGFloat(index * 10), height: 120 + CGFloat(index * 10))
                        .blur(radius: CGFloat(5 + index * 3))
                        .rotationEffect(.degrees(-90))
                }
                
                // Main ring
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        AngularGradient(
                            colors: [.purple, .pink, .blue, .cyan, .purple],
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                    .shadow(color: .purple, radius: glowIntensity * 20)
                    .animation(.easeOut(duration: 1.2), value: progress)
                
                // Animated particles along the ring
                ForEach(0..<8, id: \.self) { index in
                    Circle()
                        .fill(.white)
                        .frame(width: 4, height: 4)
                        .offset(x: 60)
                        .rotationEffect(.degrees(particleOffset + Double(index * 45)))
                        .opacity(progress > Double(index) / 8.0 ? 1 : 0)
                        .blur(radius: 0.5)
                }
                
                // Center content
                VStack {
                    Text("\(Int(progress * 100))")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(
                            LinearGradient(colors: [.purple, .pink], startPoint: .top, endPoint: .bottom)
                        )
                    Text("POWER")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .tracking(2)
                        .foregroundColor(.secondary)
                }
            }
            .onAppear {
                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                    particleOffset = 360
                }
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    glowIntensity = 1.0
                }
            }
        }
    }
}

// 6. Elastic Line Progress
struct ElasticLineProgress: View {
    let progress: Double
    @State private var elasticScale = 1.0
    @State private var sparkleOffset = 0.0
    
    var body: some View {
        VStack {
            Text("🎯 Elastic Power")
                .font(.headline)
                .fontWeight(.semibold)
            
            ZStack(alignment: .leading) {
                // Track
                Capsule()
                    .fill(.gray.opacity(0.2))
                    .frame(width: 300, height: 16)
                
                // Elastic progress fill
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [.green, .yellow, .orange, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: max(16, 300 * progress), height: 16 * elasticScale)
                    .animation(.interpolatingSpring(stiffness: 100, damping: 8), value: progress)
                
                // Sparkle effect at the end
                Circle()
                    .fill(.white)
                    .frame(width: 8, height: 8)
                    .offset(x: max(8, 300 * progress) - 4)
                    .scaleEffect(1 + sin(sparkleOffset) * 0.5)
                    .opacity(progress > 0 ? 1 : 0)
                
                // Lightning bolt when at 100%
                if progress >= 0.99 {
                    Text("⚡️")
                        .font(.title)
                        .offset(x: 280, y: -20)
                        .scaleEffect(2)
                        .opacity(0.8)
                }
            }
            .onChange(of: progress) { _, newValue in
                withAnimation(.interpolatingSpring(stiffness: 200, damping: 6)) {
                    elasticScale = 1.3
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.interpolatingSpring(stiffness: 150, damping: 8)) {
                        elasticScale = 1.0
                    }
                }
            }
            .onAppear {
                withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: false)) {
                    sparkleOffset = .pi * 4
                }
            }
        }
    }
}

// 7. Particle System Progress
struct ParticleProgress: View {
    let progress: Double
    @State private var particleAnimations: [Bool] = Array(repeating: false, count: 20)
    
    var body: some View {
        VStack {
            Text("🎆 Particle Burst")
                .font(.headline)
                .fontWeight(.semibold)
            
            ZStack {
                // Background circle
                Circle()
                    .stroke(.gray.opacity(0.2), lineWidth: 4)
                    .frame(width: 140, height: 140)
                
                // Particles
                ForEach(0..<20, id: \.self) { index in
                    Circle()
                        .fill(Color.random())
                        .frame(width: 6, height: 6)
                        .offset(
                            x: particleAnimations[index] ? cos(Double(index) * .pi / 10) * 80 : 0,
                            y: particleAnimations[index] ? sin(Double(index) * .pi / 10) * 80 : 0
                        )
                        .opacity(progress > Double(index) / 20.0 && particleAnimations[index] ? 1 : 0)
                        .scaleEffect(particleAnimations[index] ? 1 : 0)
                        .animation(
                            .interpolatingSpring(stiffness: 200, damping: 8)
                            .delay(Double(index) * 0.05),
                            value: particleAnimations[index]
                        )
                }
                
                // Center progress
                Text("\(Int(progress * 100))%")
                    .font(.title2)
                    .fontWeight(.black)
            }
            .onChange(of: progress) { _, newValue in
                for index in 0..<20 {
                    if newValue > Double(index) / 20.0 {
                        particleAnimations[index] = true
                    } else {
                        particleAnimations[index] = false
                    }
                }
            }
        }
    }
}

// Extension untuk random color
extension Color {
    static func random() -> Color {
        let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink, .cyan]
        return colors.randomElement() ?? .blue
    }
}

#Preview {
    ProgressIndocator()
}
