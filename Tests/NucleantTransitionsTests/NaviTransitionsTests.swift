//
//  NaviTransitionsTests.swift
//  NucleantTransitionsTests
//
//  NucleantNaviTransitions: every navigation transition loads its shader,
//  each is its own, and its arguments reach the stack.
//

import Testing
import NucleantNaviTransitions
import NucleantUI

@MainActor
struct NaviTransitionsTests {

    /// Every one, as an app spells it.
    private var all: [ShaderNavigationTransition] {
        [
            .blinds, .blur, .crt, .checkerboard, .chromatic, .clockWipe, .develop, .diamond,
            .dissolve, .doors, .dots, .flash, .glitch, .halftone, .ink, .iris,
            .kaleidoscope, .melt, .motionBlur, .pixelate, .ripple, .shatter, .smoke,
            .stripes, .swirl, .tiles, .wave, .wipe, .zoomBlur,
        ]
    }

    @Test func eachLoadsAndIsItsOwn() {
        let contents = all.map(\._content)
        #expect(contents.count == 29)
        #expect(Set(contents).count == contents.count)
    }

    @Test func argumentsAndTimingReachTheStack() {
        #expect(ShaderNavigationTransition.iris._content == ShaderNavigationTransition.iris(center: .center)._content)
        #expect(ShaderNavigationTransition.iris._content != ShaderNavigationTransition.iris(center: .topLeading)._content)
        #expect(ShaderNavigationTransition.dissolve._content != ShaderNavigationTransition.dissolve(edgeColor: .blue)._content)
        #expect(ShaderNavigationTransition.wipe._content != ShaderNavigationTransition.wipe(timing: .smooth(duration: 1))._content)
    }
}
