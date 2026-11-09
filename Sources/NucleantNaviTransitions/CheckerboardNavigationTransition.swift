//
//  CheckerboardNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen growing out of a checkerboard, one colour of square and then the other. Played backwards when the screen is popped.
    @MainActor
    public static var checkerboard: ShaderNavigationTransition {
        checkerboard()
    }

    /// The new screen growing out of a checkerboard, one colour of square and then the other. Played backwards when the screen is popped.
    @MainActor
    public static func checkerboard(
        cells: Double = 8,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.checkerboard.function,
            arguments: [
                .float("cells", Float(max(1, cells)))
            ],
            timing: timing
        )
    }
}
