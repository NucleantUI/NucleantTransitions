//
//  InkNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// Ink spreading from a point with a ragged, soaking edge until the new screen is covered. Played backwards when the screen is popped.
    @MainActor
    public static var ink: ShaderNavigationTransition {
        ink()
    }

    /// Ink spreading from a point with a ragged, soaking edge until the new screen is covered. Played backwards when the screen is popped.
    @MainActor
    public static func ink(
        center: UnitPoint = .center,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.ink.function,
            arguments: [
                .float2("center", Float2(center.x, center.y))
            ],
            timing: timing
        )
    }
}
