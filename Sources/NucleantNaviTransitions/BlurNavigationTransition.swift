//
//  BlurNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen coming into focus over the one below. Played backwards when the screen is popped.
    @MainActor
    public static var blur: ShaderNavigationTransition {
        blur()
    }

    /// The new screen coming into focus over the one below. Played backwards when the screen is popped.
    @MainActor
    public static func blur(
        radius: Double = 24,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.blur.function,
            arguments: [
                .float("radius", Float(max(0, radius)))
            ],
            timing: timing
        )
    }
}
