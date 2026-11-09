//
//  StripesNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// Level strips of the new screen sliding in from alternate sides, one after another. Played backwards when the screen is popped.
    @MainActor
    public static var stripes: ShaderNavigationTransition {
        stripes()
    }

    /// Level strips of the new screen sliding in from alternate sides, one after another. Played backwards when the screen is popped.
    @MainActor
    public static func stripes(
        count: Double = 8,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.stripes.function,
            arguments: [
                .float("count", Float(max(1, count)))
            ],
            timing: timing
        )
    }
}
