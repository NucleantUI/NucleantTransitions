//
//  MeltNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen dripping down into place, column by column. Played backwards when the screen is popped.
    @MainActor
    public static var melt: ShaderNavigationTransition {
        melt()
    }

    /// The new screen dripping down into place, column by column. Played backwards when the screen is popped.
    @MainActor
    public static func melt(
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.melt.function,
            timing: timing
        )
    }
}
