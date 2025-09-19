import Foundation

//enum Framework: String, Codable { case swiftUI, coreAnimation }

//enum AnimationDemo: String, Codable { case dragGestures, pyhsics, orb }

struct AnimationItemModel: Identifiable, Codable, Equatable, Hashable {
    var id: String
    var title: String
    let summary: String
    let renderer: String
    let framework: String
    let tags: [String]
    let codeSwift: String
    let controlSpecs: [ControlSpec]
}

struct ControlSpec: Codable, Identifiable, Equatable, Hashable {
  enum Kind: String, Codable { case slider, toggle, picker }
  let id: String
  let key: String        // animation's modifier/parameter
  let title: String
  let kind: Kind
  let min: Double?
  let max: Double?
  let step: Double?
  let options: [String]?
  let defaultValue: Double?
}
