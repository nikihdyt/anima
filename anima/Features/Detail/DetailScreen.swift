import SwiftUI

struct DetailScreen: View {
  @StateObject var vm: DetailViewModel
  @State private var tab: Int = 0

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Picker("", selection: $tab) {
        Text("Preview").tag(0)
        Text("Code").tag(1)
      }
      .pickerStyle(.segmented)

      if tab == 0 {
        ZStack {
          RoundedRectangle(cornerRadius: 16).fill(.quaternary)
            switch vm.example.renderer {
            case "dragGesture":
                dragGesture()
                    .padding()
            case "orb1":
                Orb1()
                    .padding()
            case "gradient sphere":
                Timeline_Gradient3()
            default :
                ExamplePreview(example: vm.example, params: vm.params)
                  .padding()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 280)

        ForEach(vm.example.controlSpecs) { spec in
          switch spec.kind {
          case .slider:
            VStack(alignment: .leading) {
              Text("\(spec.title): \(vm.params[spec.key] ?? 0, specifier: "%.2f")")
              Slider(value: Binding(
                get: { vm.params[spec.key] ?? (spec.defaultValue ?? 0) },
                set: { vm.params[spec.key] = $0 }),
                in: (spec.min ?? 0)...(spec.max ?? 1),
                step: spec.step ?? 0.01
              )
            }
          default:
            Toggle(spec.title, isOn: Binding(
              get: { (vm.params[spec.key] ?? 0) > 0.5 },
              set: { vm.params[spec.key] = $0 ? 1 : 0 }
            ))
          }
        }

        HStack {
          Spacer()
          Button("Reset") { vm.reset() }
        }
      } else {
//          MarkdownReader.extractCode(from: vm.example.codeSwift)
        ScrollView {
          Text(vm.example.codeSwift)
            .textSelection(.enabled)
            .font(.system(.body, design: .monospaced))
            .padding(.top, 8)
        }
      }
    }
    .padding()
    .navigationTitle(vm.example.title)
  }
}

