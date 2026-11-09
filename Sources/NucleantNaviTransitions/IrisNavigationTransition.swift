//
//  IrisNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// A circle opening from a point until the new screen fills it. Played backwards when the screen is popped.
    @MainActor
    public static var iris: ShaderNavigationTransition {
        iris()
    }

    /// A circle opening from a point until the new screen fills it. Played backwards when the screen is popped.
    @MainActor
    public static func iris(
        center: UnitPoint = .center,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.iris.function,
            arguments: [
                .float2("center", Float2(center.x, center.y))
            ],
            timing: timing
        )
    }
}
