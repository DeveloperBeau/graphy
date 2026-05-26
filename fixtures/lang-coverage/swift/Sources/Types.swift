// feature: class, struct, enum, protocol
import Foundation

protocol Greeter {
    func hi() -> String
}

enum State {
    case idle
    case running
    case done
}

struct Point {
    var x: Int
    var y: Int
}

class BaseService {
    var name: String
    init(name: String) {
        self.name = name
    }
}
