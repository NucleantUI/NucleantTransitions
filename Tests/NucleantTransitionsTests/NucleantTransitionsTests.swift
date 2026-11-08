//
//  NucleantTransitionsTests.swift
//  NucleantTransitionsTests
//

import Foundation
import Testing
import NucleantUI
@testable import NucleantTransitions

@MainActor
struct ShaderModuleTests {

    /// Every shader the transitions name was compiled by the build plugin
    /// and is in the library's bundle as SPIR-V, with a `main` to run.
    @Test(arguments: [
        "Ripple", "Dissolve", "Pixelate", "Swirl", "Glitch", "Wipe", "ClockWipe", "Iris",
        "Diamond", "Blinds", "Checkerboard", "Tiles", "Shatter", "Wave", "ZoomBlur",
        "MotionBlur", "Chromatic", "Kaleidoscope", "Doors", "Halftone", "Melt", "Stripes",
        "Dots", "CRT", "Flash", "Smoke", "Ink", "Blur", "Develop",
    ])
    func compiledIntoTheBundle(name: String) throws {
        let url = try #require(Bundle.module(for: name))
        let data = try Data(contentsOf: url)
        let words = data.withUnsafeBytes { Array($0.bindMemory(to: UInt32.self)) }
        #expect(words.first == 0x0723_0203, "SPIR-V magic number")
        let text = String(decoding: data, as: UTF8.self)
        #expect(text.contains("main"))
    }
}

@MainActor
struct PhaseTests {

    /// All of the view in `identity`, none of it on either side — so the
    /// shader is off while the view is simply shown.
    @Test func progressPerPhase() {
        #expect(TransitionPhase.willAppear.progress == 0)
        #expect(TransitionPhase.identity.progress == 1)
        #expect(TransitionPhase.didDisappear.progress == 0)
    }

    /// The static spellings make the same transitions as the initializers.
    @Test func staticSpellings() {
        #expect(RippleTransition.ripple == RippleTransition(center: .center))
        #expect(RippleTransition.ripple(from: .topLeading).center == .topLeading)
        #expect(DissolveTransition.dissolve(edgeColor: .blue).edgeColor == .blue)
        #expect(PixelateTransition.pixelate.blockSize == 48)
        #expect(SwirlTransition.swirl(turns: -2).turns == -2)
        #expect(GlitchTransition.glitch(strength: 0.5).strength == 0.5)
    }

    /// Only the transitions that move the view say they have motion.
    @Test func motion() {
        #expect(RippleTransition.properties.hasMotion)
        #expect(SwirlTransition.properties.hasMotion)
        #expect(GlitchTransition.properties.hasMotion)
        #expect(!DissolveTransition.properties.hasMotion)
        #expect(!PixelateTransition.properties.hasMotion)
    }
}

@MainActor
struct LoadingTests {

    /// Each transition's shader loads under the name its section has in
    /// `pyshader.toml` — a missing one stops the app.
    @Test func shadersLoadByName() {
        let shaders: [(TransitionShader, String)] = [
            (.ripple, "Ripple"), (.wipe, "Wipe"), (.clockWipe, "ClockWipe"), (.motionBlur, "MotionBlur"),
            (.crt, "CRT"), (.develop, "Develop"), (.shatter, "Shatter"), (.dots, "Dots"),
        ]
        for (shader, name) in shaders {
            #expect(shader.name == name)
            #expect(shader.function.language == .spirv)
        }
    }

    /// Something coming in through an edge travels away from it.
    @Test func edgesPointInward() {
        #expect(Edge.leading.travel == Float2(1, 0))
        #expect(Edge.top.travel == Float2(0, 1))
        #expect(Edge.trailing.inward == .degrees(180))
        #expect(Edge.bottom.inward == .degrees(-90))
    }
}
