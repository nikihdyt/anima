//
//  ScrollEffectPlayground.swift
//  anima
//
//  Created by Niki Hidayati on 17/09/25.
//

import SwiftUI

struct ScrollEffectPlayground: View {
    
    var body: some View {
        ScrollView {
            ForEach(0..<10) { index in
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: 100)
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.5)
                                .scaleEffect(1 - abs(phase.value))
                        }
                }
        }
    }
}

#Preview {
    ScrollEffectPlayground()
}
