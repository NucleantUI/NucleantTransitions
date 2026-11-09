//
//  KaleidoscopeNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen folded into a turning kaleidoscope that opens out into it. Played backwards when the screen is popped.
    @MainActor
    public static var kaleidoscope: ShaderNavigationTransition {
        kaleidoscope()
    }

    /// The new screen folded into a turning kaleidoscope that opens out into it. Played backwards when the screen is popped.
    @MainActor
    public static func kaleidoscope(
        segments: Double = 8,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.kaleidoscope.function,
            arguments: [
                .float("segments", Float(max(2, segments)))
            ],
            timing: timing
        )
    }
}
