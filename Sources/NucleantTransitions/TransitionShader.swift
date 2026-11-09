//
//  TransitionShader.swift
//  NucleantTransitions
//
//  The package's shaders, as the SPIR-V PyShader's build plugin compiled
//  `Shaders/<name>.py` to, read once from the library's bundle.
//

import Foundation
import NucleantUI

/// One of the package's compiled shaders — NucleantNaviTransitions plays them
/// over whole screens.
@MainActor
package final class TransitionShader {

    /// The `Shaders/<name>.py` it was compiled from, and the section of
    /// `pyshader.toml` that lists it.
    let name: String

    /// The module, ready for `.shader(_:arguments:)`. None of them reads
    /// the clock or the pointer: each draws again only when its progress
    /// moves.
    package let function: ShaderFunction

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

    package static let ripple = TransitionShader(named: "Ripple")
    package static let dissolve = TransitionShader(named: "Dissolve")
    package static let pixelate = TransitionShader(named: "Pixelate")
    package static let swirl = TransitionShader(named: "Swirl")
    package static let glitch = TransitionShader(named: "Glitch")
    package static let wipe = TransitionShader(named: "Wipe")
    package static let clockWipe = TransitionShader(named: "ClockWipe")
    package static let iris = TransitionShader(named: "Iris")
    package static let diamond = TransitionShader(named: "Diamond")
    package static let blinds = TransitionShader(named: "Blinds")
    package static let checkerboard = TransitionShader(named: "Checkerboard")
    package static let tiles = TransitionShader(named: "Tiles")
    package static let shatter = TransitionShader(named: "Shatter")
    package static let wave = TransitionShader(named: "Wave")
    package static let zoomBlur = TransitionShader(named: "ZoomBlur")
    package static let motionBlur = TransitionShader(named: "MotionBlur")
    package static let chromatic = TransitionShader(named: "Chromatic")
    package static let kaleidoscope = TransitionShader(named: "Kaleidoscope")
    package static let doors = TransitionShader(named: "Doors")
    package static let halftone = TransitionShader(named: "Halftone")
    package static let melt = TransitionShader(named: "Melt")
    package static let stripes = TransitionShader(named: "Stripes")
    package static let dots = TransitionShader(named: "Dots")
    package static let crt = TransitionShader(named: "CRT")
    package static let flash = TransitionShader(named: "Flash")
    package static let smoke = TransitionShader(named: "Smoke")
    package static let ink = TransitionShader(named: "Ink")
    package static let blur = TransitionShader(named: "Blur")
    package static let develop = TransitionShader(named: "Develop")
}
