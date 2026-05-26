// feature: top-level function, called cross-file
import Foundation

func formatName(_ name: String) -> String {
    return "hi, " + name.trimmingCharacters(in: .whitespaces)
}

func unrelatedHelper() -> Int {
    return 7
}
