//
//  TransitionShader.swift
//  NucleantTransitions
//
//  The package's shaders, as the SPIR-V PyShader's build plugin compiled
//  `Shaders/<name>.py` to, read once from the library's bundle.
//

import Foundation
import NucleantUI

/// One of the package's compiled shaders.
@MainActor
final class TransitionShader {

    /// The `Shaders/<name>.py` it was compiled from, and the section of
    /// `pyshader.toml` that lists it.
    let name: String

    /// The module, ready for `.shader(_:arguments:)`. None of them reads
    /// the clock or the pointer: each draws again only when its progress
    /// moves.
    let function: ShaderFunction

    private init(named name: String) {
        guard let url = Self.bundle.url(forResource: name, withExtension: "spv"),
              let data = try? Data(contentsOf: url)
        else {
            fatalError("NucleantTransitions: \(name).spv is not among the library's resources — is it in pyshader.toml?")
        }
        self.name = name
        let words = data.withUnsafeBytes { Array($0.bindMemory(to: UInt32.self)) }
        self.function = ShaderFunction(spirv: words, isAnimated: false)
    }

    /// The library's resources, where the build plugin put the modules.
    nonisolated static var bundle: Bundle { .module }

    static let ripple = TransitionShader(named: "Ripple")
    static let dissolve = TransitionShader(named: "Dissolve")
    static let pixelate = TransitionShader(named: "Pixelate")
    static let swirl = TransitionShader(named: "Swirl")
    static let glitch = TransitionShader(named: "Glitch")
}
