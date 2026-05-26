// feature: class inheriting BaseService, protocol conformance, init, deinit,
//          cross-file call, external call (print must not produce local edge)
import Foundation

class Service: BaseService, Greeter {
    private var cache: [String: String] = [:]

    override init(name: String) {
        super.init(name: name)
    }

    deinit {
        cache.removeAll()
    }

    func hi() -> String {
        return "hello from " + name
    }

    func run() {
        let greeting = formatName(name)
        print(greeting)
    }
}
