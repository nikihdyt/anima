import SwiftUI

final class DetailViewModel: ObservableObject {
    let example: AnimationItemModel

  // current control values
  @Published var params: [String: Double] = [:] // key := ControlSpec.key

    init(example: AnimationItemModel) {
    self.example = example
    self.params = Dictionary(uniqueKeysWithValues: example.controlSpecs.map { spec in
      (spec.key, spec.defaultValue ?? 0)
    })
  }

  func reset() {
    for spec in example.controlSpecs {
      params[spec.key] = spec.defaultValue ?? 0
    }
  }
}
