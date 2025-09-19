import SwiftUI

struct LiquidFlowProgressIndocator: View {
    @State private var progress: Double = 0.5
    @State private var isAutoAnimating = false
    
    var body: some View {
        VStack(spacing: 20) {
            LiquidProgressBar(progress: progress)
            
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
            .padding(.horizontal)
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

struct LiquidProgressBar: View {
    let progress: Double
    @State private var waveOffset = 0.0
    @State private var bubbleOffset = 0.0
    @State private var waveTimer: Timer?
    @State private var bubbleTimer: Timer?
    
    var body: some View {
        VStack {
            Text("🌊 Liquid Flow")
                .font(.headline)
                .fontWeight(.semibold)
            
            ZStack {
                // Container dengan glass effect
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.white.opacity(0.3), lineWidth: 2)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.ultraThinMaterial)
                    )
                    .frame(width: 280, height: 100)
                
                // Liquid fill dengan multiple waves
                ZStack {
                    LiquidWave(offset: waveOffset, progress: progress, amplitude: 8)
                        .fill(
                            LinearGradient(
                                colors: [.cyan.opacity(0.8), .blue],
                                startPoint: .top, endPoint: .bottom
                            )
                        )
                    
                    LiquidWave(offset: waveOffset * 1.5, progress: progress, amplitude: 5)
                        .fill(
                            LinearGradient(
                                colors: [.white.opacity(0.3), .clear],
                                startPoint: .top, endPoint: .bottom
                            )
                        )
                }
                .clipShape(RoundedRectangle(cornerRadius: 23))
                .frame(width: 276, height: 100)
                .animation(.easeOut(duration: 0.8), value: progress)
                
                // Floating bubbles
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(.white.opacity(0.6))
                        .frame(width: CGFloat([4, 6, 3][index]))
                        .offset(
                            x: -100 + (200 * progress) + sin(bubbleOffset + Double(index)) * 20,
                            y: sin(bubbleOffset * 1.5 + Double(index) * 2) * 15
                        )
                        .opacity(progress > 0.1 ? 1 : 0)
                }
                
                // Progress text dengan glow effect
                Text("\(Int(progress * 100))%")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .cyan, radius: 5)
            }
            .onAppear {
                startTimerBasedAnimations()
            }
            .onDisappear {
                stopTimerBasedAnimations()
            }
        }
    }
    
    private func startTimerBasedAnimations() {
        // Stop existing timers
        stopTimerBasedAnimations()
        
        // Wave animation timer
        waveTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            waveOffset += 2.0
            if waveOffset >= 360 {
                waveOffset = 0
            }
        }
        
        // Bubble animation timer
        bubbleTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            bubbleOffset += 0.2
        }
    }
    
    private func stopTimerBasedAnimations() {
        waveTimer?.invalidate()
        waveTimer = nil
        bubbleTimer?.invalidate()
        bubbleTimer = nil
    }
}

struct LiquidWave: Shape {
    var offset: Double
    var progress: Double
    var amplitude: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(offset, progress) }
        set {
            offset = newValue.first
            progress = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let yPosition = rect.height * (1 - progress)
        
        path.move(to: CGPoint(x: 0, y: yPosition))
        
        for x in stride(from: 0, through: rect.width, by: 2) {
            let y = yPosition + sin((x / 30) + offset * .pi / 180) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    LiquidFlowProgressIndocator()
}
