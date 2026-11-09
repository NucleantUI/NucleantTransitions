//
//  DiamondNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// A diamond opening from a point until the new screen fills it. Played backwards when the screen is popped.
    @MainActor
    public static var diamond: ShaderNavigationTransition {
        diamond()
    }

    /// A diamond opening from a point until the new screen fills it. Played backwards when the screen is popped.
    @MainActor
    public static func diamond(
        center: UnitPoint = .center,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.diamond.function,
            arguments: [
                .float2("center", Float2(center.x, center.y))
            ],
            timing: timing
        )
    }
}
