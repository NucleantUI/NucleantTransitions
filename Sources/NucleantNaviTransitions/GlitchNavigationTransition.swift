//
//  GlitchNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen torn into slices jumping sideways until they line up. Played backwards when the screen is popped.
    @MainActor
    public static var glitch: ShaderNavigationTransition {
        glitch()
    }

    /// The new screen torn into slices jumping sideways until they line up. Played backwards when the screen is popped.
    @MainActor
    public static func glitch(
        strength: Double = 0.25,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.glitch.function,
            arguments: [
                .float("strength", Float(strength))
            ],
            timing: timing
        )
    }
}
