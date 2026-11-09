//
//  SwirlNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen unwinding out of its centre. Played backwards when the screen is popped.
    @MainActor
    public static var swirl: ShaderNavigationTransition {
        swirl()
    }

    /// The new screen unwinding out of its centre. Played backwards when the screen is popped.
    @MainActor
    public static func swirl(
        turns: Double = 1.5,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.swirl.function,
            arguments: [
                .float("turns", Float(turns))
            ],
            timing: timing
        )
    }
}
