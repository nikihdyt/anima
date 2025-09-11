import Foundation

final class ListViewModel: ObservableObject {
    @Published private(set) var all: [AnimationItemModel] = []
    @Published var query: String = ""
    @Published private(set) var filtered: [AnimationItemModel] = []

    private let loader: ExamplesLoader

    init(loader: ExamplesLoader = BundleExamplesLoader()) {
    self.loader = loader
    }

    func onAppear() {
        if all.isEmpty {
            do {
                all = try loader.load()
                print("Loaded items =", all.count)
            } catch {
                print("LOAD ERROR →", error)
                all = []
            }
            applyFilter()
        }

    }

    func applyFilter() {
    let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    filtered = q.isEmpty
      ? all
      : all.filter { $0.title.lowercased().contains(q) || $0.tags.contains(where: { $0.lowercased().contains(q) }) }
        print("here")
    }
}
