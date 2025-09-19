import SwiftUI

struct Timeline_Gradient3: View {
    @State private var dragAmount = CGSize.zero
    @State private var finalAmount = CGSize.zero
    @State private var velocity = CGSize.zero
    @State private var isAnimating = false
    
    let containerSize: CGSize = CGSize(width: 300, height: 500)
    let objectSize: CGSize = CGSize(width: 50, height: 50)
    
    // Physics parameters
    let damping: Double = 0.8
    let bounciness: Double = 0.7
    let gravity: Double = 0.2
    let friction: Double = 0.99
    
    var body: some View {
        Rectangle()
            .stroke(.orange, lineWidth: 4)
            .frame(width: containerSize.width, height: containerSize.height)
            .overlay(
                TimelineView(.animation) { timeline in
                    let seconds = timeline.date.timeIntervalSince1970
                    
                    MeshGradient(
width: 2,
height: 2,
points: [
    [0, 0],
    [0, 1],
    [1, 0],
    [1, 1] ],
colors: [
    .blue,
    .purple,
    .pink,
    .red
]
                    )
                    .rotationEffect(.degrees(seconds * 100))
                    .frame(width: objectSize.width, height: objectSize.height)
                    .clipShape(.circle)
                    .offset(x: finalAmount.width + dragAmount.width,
                            y: finalAmount.height + dragAmount.height)
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                if !isAnimating {
                                    dragAmount = value.translation
                                }
                            }
                            .onEnded{ value in
                                velocity = CGSize(
                                    width: value.translation.width * 0.1,
                                    height: value.translation.height * 0.1
                                )
                                finalAmount.width += dragAmount.width
                                finalAmount.height += dragAmount.height
                                dragAmount = .zero
                                
                                startAdvancedPhysics()
                            }
                    )
                    .animation(
                        .spring(response: 0.3, dampingFraction: 0.8),
                        value: dragAmount
                    )
                }
            )
            .clipped()
    }
    
    private func startAdvancedPhysics() {
        guard !isAnimating else { return }
        isAnimating = true
        
        Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { timer in
            // Apply gravity (hanya ke Y)
            velocity.height += gravity
            
            // Apply friction
            velocity.width *= friction
            velocity.height *= friction
            
            // Update position
            finalAmount.width += velocity.width
            finalAmount.height += velocity.height
            
            // Boundaries
            let maxX = (containerSize.width - objectSize.width) / 2
            let maxY = (containerSize.height - objectSize.height) / 2
            let minX = -maxX
            let minY = -maxY
            
            if finalAmount.width > maxX {
                finalAmount.width = maxX
                velocity.width = -velocity.width * bounciness
                velocity.width += Double.random(in: -0.5...0.5)
            } else if finalAmount.width < minX {
                finalAmount.width = minX
                velocity.width = -velocity.width * bounciness
                velocity.width += Double.random(in: -0.5...0.5)
            }
            
            if finalAmount.height > maxY {
                finalAmount.height = maxY
                velocity.height = -velocity.height * bounciness
                velocity.height += Double.random(in: -0.5...0.5)
            } else if finalAmount.height < minY {
                finalAmount.height = minY
                velocity.height = -velocity.height * bounciness
                velocity.height += Double.random(in: -0.5...0.5)
            }
            
            if abs(velocity.width) < 0.2 && abs(velocity.height) < 0.2 &&
                finalAmount.height >= maxY - 1 {
                timer.invalidate()
                isAnimating = false
                velocity = .zero
                finalAmount.height = maxY
            }
        }
    }


}

#Preview {
    Timeline_Gradient3()
}
