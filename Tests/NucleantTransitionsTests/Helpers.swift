import Foundation
@testable import NucleantTransitions

extension Bundle {
    /// `<name>.spv` in the library's bundle.
    static func module(for name: String) -> URL? {
        TransitionShader.bundle.url(forResource: name, withExtension: "spv")
    }
}
