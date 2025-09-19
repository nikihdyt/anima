//
//  ShapesPlayground.swift
//  anima
//
//  Created by Niki Hidayati on 16/09/25.
//

import SwiftUI

struct ShapesPlayground: View {
    var body: some View {
//        ZStack {
//            Circle()
//                .frame(width: 200, height: 200)
//            Rectangle()
//                .clipShape(Ellipse())
//                .frame(width: 50, height: 20)
//                .foregroundColor(Color.red)
//            
//            
//        }
        VStack {
            Triangle2()
            Circle()
                .inset(by: 10)
                .stroke(.blue, lineWidth: 2)
        }
    }
}

struct Triangle2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))       // titik atas
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))    // kanan bawah
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))    // kiri bawah
        path.closeSubpath()  // nutup garis
        return path
    }
}


#Preview {
    ShapesPlayground()
        .frame(width: 100, height: 100)
}
