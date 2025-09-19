//
//  TransationDemo.swift
//  anima
//
//  Created by Niki Hidayati on 11/09/25.
//

import SwiftUI

// demonstrate zoom transtation in swiftui (ios 18 feature)
struct Bracelate {
    let name: String
    let image: String
}

struct BraceletEditor: View {
    @State var bracelet: Bracelate
    
    init(bracelet: Bracelate) {
        self.bracelet = bracelet
    }
    
    var body: some View {
        VStack {
            Text("Bracelet Editor")
                .foregroundStyle(.black)
            Text(bracelet.name)
            Spacer()
        }
        .padding()
    }
}

struct BraceletPreview: View {
    @State var bracelet: Bracelate
    
    init(bracelet: Bracelate) {
        self.bracelet = bracelet
    }
    
    var body: some View {
        VStack {
            Text("Bracelet Preview")
                .foregroundStyle(.black)
            Image(bracelet.image)
                .resizable()
                .scaledToFit()
        }
        .padding()
    }
}

struct TransationDemoView: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

struct TransationDemo: View {
    let b = Bracelate(name: "test", image: "demo_transition_bracelet")
    var body: some View {
        NavigationLink() {
            BraceletEditor(bracelet: b)
        } label: {
//            BraceletPreview(bracelet: b)
            Button("dklnkdl") {}
        }
    }
}

#Preview {
    TransationDemo()
}
