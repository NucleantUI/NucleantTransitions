//
//  DoorsNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The two halves of the new screen sliding in from either side and meeting in the middle. Played backwards when the screen is popped.
    @MainActor
    public static var doors: ShaderNavigationTransition {
        doors()
    }

    /// The two halves of the new screen sliding in from either side and meeting in the middle. Played backwards when the screen is popped.
    @MainActor
    public static func doors(
        axis: Axis = .horizontal,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.doors.function,
            arguments: [
                .float("vertical", axis == .vertical ? 1 : 0)
            ],
            timing: timing
        )
    }
}
