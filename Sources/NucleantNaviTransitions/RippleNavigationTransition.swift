//
//  RippleNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen revealed in a circle growing from a point, rippling at its edge. Played backwards when the screen is popped.
    @MainActor
    public static var ripple: ShaderNavigationTransition {
        ripple()
    }

    /// The new screen revealed in a circle growing from a point, rippling at its edge. Played backwards when the screen is popped.
    @MainActor
    public static func ripple(
        center: UnitPoint = .center,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.ripple.function,
            arguments: [
                .float2("center", Float2(center.x, center.y))
            ],
            timing: timing
        )
    }
}
