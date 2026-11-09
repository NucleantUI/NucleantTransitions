//
//  DevelopNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen developing like a photograph: dark and grey first, its colour coming up after. Played backwards when the screen is popped.
    @MainActor
    public static var develop: ShaderNavigationTransition {
        develop()
    }

    /// The new screen developing like a photograph: dark and grey first, its colour coming up after. Played backwards when the screen is popped.
    @MainActor
    public static func develop(
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.develop.function,
            timing: timing
        )
    }
}
