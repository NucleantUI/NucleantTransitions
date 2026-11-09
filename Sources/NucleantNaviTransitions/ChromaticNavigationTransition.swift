//
//  ChromaticNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen's colour channels flying in from its centre and settling on each other. Played backwards when the screen is popped.
    @MainActor
    public static var chromatic: ShaderNavigationTransition {
        chromatic()
    }

    /// The new screen's colour channels flying in from its centre and settling on each other. Played backwards when the screen is popped.
    @MainActor
    public static func chromatic(
        strength: Double = 0.12,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.chromatic.function,
            arguments: [
                .float("strength", Float(strength))
            ],
            timing: timing
        )
    }
}
