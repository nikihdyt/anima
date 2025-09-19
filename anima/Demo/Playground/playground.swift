//
//  playground.swift
//  anima
//
//  Created by Niki Hidayati on 12/09/25.
//

import SwiftUI

struct playground: View {
    @State private var isOffset = false
    
    var body: some View {
        Image(systemName: "bubbles.and.sparkles.fill")
            .font(.system(size: 144, weight: .black))
            .foregroundStyle(
                MeshGradient(width: 2, height: 2, points: [
                    [0, 0], [1, 0],
                    [0, 1], [1, 1]
                ], colors: [
                    .indigo, .cyan,
                    .purple, .pink
                ])
            )
    }
}

#Preview {
    playground()
}
