//
//  dragGesture.swift
//  anima
//
//  Created by Niki Hidayati on 12/09/25.
//

import SwiftUI

struct dragGesture: View {
    @State private var dragAmount = CGSize.zero
    @State private var finalAmount = CGSize.zero
    
    var body: some View {
        MeshGradient(
width: 2,
height: 2,
points: [
    [0, 0],
    [0, 1],
    [0.7, 0],
    [1, 1] ],
colors: [
    .blue,
    .purple,
    .pink,
    .red
]
        )
        .background(.orange)
        .frame(width: 300, height: 200)
        .clipShape(.rect(cornerRadius: 20))
        .offset(x: finalAmount.width + dragAmount.width,
                y: finalAmount.height + dragAmount.height)
        .gesture(
            DragGesture()
                .onChanged{ dragAmount = $0.translation }
                .onEnded{ _ in
                    finalAmount.width += dragAmount.width
                    finalAmount.height += dragAmount.height
                    dragAmount = .zero
                }
        )
        .animation(.spring, value: dragAmount)
    }
}

#Preview {
    dragGesture()
}
