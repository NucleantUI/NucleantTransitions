//
//  SmokeNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen gathering out of drifting smoke. Played backwards when the screen is popped.
    @MainActor
    public static var smoke: ShaderNavigationTransition {
        smoke()
    }

    /// The new screen gathering out of drifting smoke. Played backwards when the screen is popped.
    @MainActor
    public static func smoke(
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.smoke.function,
            timing: timing
        )
    }
}
