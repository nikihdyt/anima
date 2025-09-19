//
//  VisEffectPlaygroundParallax.swift
//  anima
//
//  Created by Niki Hidayati on 17/09/25.
//

import SwiftUI

struct ScrollEffectPrallax: View {
    let beachesImg = ["beach0", "beach6", "beach0", "beach6", "beach0"]
    
    var body: some View {
        AnimalPhoto(imgs: beachesImg)
            .scrollTransition(
                axis: .horizontal) {
                    content, phase in
                    content
                        .opacity(1 - phase.value)
                }
    }
}

struct AnimalPhoto: View {
    @State var imgs: [String]
    
    var body: some View {
        ScrollView {
            ForEach(imgs, id: \.self) { img in
                Image(img)
                    .resizable()
                    .frame(width: 200, height: 300)
                    
            }
        }
        .padding()
    }
}

#Preview {
    let beachesImg = ["beach0", "beach6", "beach0", "beach6", "beach0"]
    AnimalPhoto(imgs: beachesImg)
}
