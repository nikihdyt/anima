import SwiftUI

struct ListScreen: View {
    @StateObject var vm = ListViewModel()
    
    init(vm: ListViewModel = ListViewModel()) {
        _vm = StateObject(wrappedValue: vm)
      }
    
    var body: some View {
        NavigationSplitView {
          VStack {
            TextField("Search", text: $vm.query)
              .textFieldStyle(.roundedBorder)
              .onChange(of: vm.query) {
                  vm.applyFilter()
              }

            List(vm.filtered) { item in
              NavigationLink(value: item) {
                VStack(alignment: .leading) {
                  Text(item.title).font(.headline)
                  Text(item.summary).font(.subheadline).foregroundStyle(.secondary)
                }
              }
            }
            .listStyle(.plain)
          }
          .padding()
          .onAppear { vm.onAppear() }
          .navigationDestination(for: AnimationItemModel.self) { ex in
              DetailScreen(vm: DetailViewModel(example: ex))
              }
        } detail: {
          Text("Pick an example")
            .foregroundStyle(.secondary)
        }
        
      }
}

struct DummyExamplesLoader: ExamplesLoader {
    func load() throws -> [AnimationItemModel] {
        [
            .init(id: "bounce", title: "Bounce", summary: "Simple bounce", framework: "coreAnimation", tags: ["bounce"], codeSwift: "let b", controlSpecs: []),
            .init(id: "fade", title: "Fade", summary: "Fade in/out", framework: "swiftUI", tags: ["fade"], codeSwift: "ndvl", controlSpecs: [])
        ]
    }
}

#Preview("ListScreen • iPad (Split)") {
  ListScreen()
}


