import Foundation

protocol ExamplesLoader { func load() throws -> [AnimationItemModel] }

struct BundleExamplesLoader: ExamplesLoader {
    enum Err: Error { case fileMissing, read(Error), decode(Error) }

    func load() throws -> [AnimationItemModel] {
        let bundle = Bundle.main

        if let url = bundle.url(forResource: "listOfAnimations", withExtension: "json") {
            return try decode(from: url)
        }

        if let path = bundle.resourcePath {
            let files = try? FileManager.default.subpathsOfDirectory(atPath: path)
            print("Bundle at:", path)
            print("Sample files:", files?.prefix(20) ?? [])
            if let match = files?.first(where: { $0.hasSuffix("/examples.json") || $0 == "examples.json" }) {
                let url = URL(fileURLWithPath: path).appendingPathComponent(match)
                return try decode(from: url)
            }
        }

        throw Err.fileMissing
    }

    private func decode(from url: URL) throws -> [AnimationItemModel] {
        do {
            let data = try Data(contentsOf: url)
            let dec = JSONDecoder()
            return try dec.decode([AnimationItemModel].self, from: data)
        } catch let e as DecodingError {
            throw Err.decode(e)
        } catch {
            throw Err.read(error)
        }
    }
}
