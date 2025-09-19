import SwiftUI

struct Timeline_Gradient2: View {
    @State private var dragAmount = CGSize.zero
    @State private var finalAmount = CGSize.zero
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let x = (sin(timeline.date.timeIntervalSince1970) + 1) / 2

            MeshGradient(width: 3, height: 3, points: [
                [0, 0], [0.5, 0], [1, 0],
                [0, 0.5], [Float(x), 0.5], [1, 0.5],
                [0, 1], [0.5, 1], [1, 1]
            ], colors: [
                .red, .red, .red,
                .red, .yellow, .red,
                .red, .red, .red
            ])
        }
    }
}

#Preview {
    Timeline_Gradient2()
}
