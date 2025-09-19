import SwiftUI

struct RippleDemo: View {
    @State private var animateRipple = false

    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 50, height: 50)
            .scaleEffect(animateRipple ? 2.0 : 1.0)
            .opacity(animateRipple ? 0.0 : 1.0)    // Fade out
            .onAppear {
                withAnimation(.easeOut(duration: 1.0).repeatForever(autoreverses: false)) {
                    animateRipple.toggle()
                }
            }
    }
}

#Preview {
    RippleDemo()
}
