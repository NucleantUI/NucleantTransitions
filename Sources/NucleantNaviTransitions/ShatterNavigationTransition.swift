//
//  ShatterNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// Shards of the new screen flying in, turning as they come, and settling into it. Played backwards when the screen is popped.
    @MainActor
    public static var shatter: ShaderNavigationTransition {
        shatter()
    }

    /// Shards of the new screen flying in, turning as they come, and settling into it. Played backwards when the screen is popped.
    @MainActor
    public static func shatter(
        cells: Double = 6,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.shatter.function,
            arguments: [
                .float("cells", Float(max(1, cells)))
            ],
            timing: timing
        )
    }
}
