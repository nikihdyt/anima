import SwiftUI

struct ExamplePreview: View {
    let example: AnimationItemModel
  let params: [String: Double]

  var body: some View {
    switch example.id {
    case "spring-scale":
      SpringScaleDemo(
        damping: params["damping"] ?? 0.7,
        stiffness: params["stiffness"] ?? 120
      )
    default:
      Text("Preview not implemented yet").foregroundStyle(.secondary)
    }
  }
}

struct SpringScaleDemo: View {
  let damping: Double
  let stiffness: Double
  @State private var big = false
  var body: some View {
    Circle().frame(width: 80, height: 80)
      .scaleEffect(big ? 1.3 : 1.0)
      .animation(.interactiveSpring(dampingFraction: damping), value: big)
      .onTapGesture { big.toggle() }
  }
}


#if DEBUG
extension AnimationItemModel {
  static func previewSpringScale() -> AnimationItemModel {
    .init(
      id: "spring-scale",
      title: "Spring Scale",
      summary: "Tap to scale with spring",
      framework: "swiftUI",
      tags: ["spring","scale"],
      codeSwift: "",
      controlSpecs: [
        
      ]
    )
  }
}
#endif

#Preview("ExamplePreview • Default") {
  ExamplePreview(
    example: .previewSpringScale(),
    params: ["damping": 0.7, "stiffness": 120]
  )
  .padding()
}

#Preview("Dark • Larger Text") {
  ExamplePreview(
    example: .previewSpringScale(),
    params: ["damping": 0.8, "stiffness": 160]
  )
  .padding()
  .preferredColorScheme(.dark)
  .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}

#Preview("iPad Landscape") {
  ExamplePreview(
    example: .previewSpringScale(),
    params: ["damping": 0.6, "stiffness": 200]
  )
  .padding()
}


#Preview("SpringScaleDemo • Direct") {
  SpringScaleDemo(damping: 0.7, stiffness: 120)
    .padding()
}
