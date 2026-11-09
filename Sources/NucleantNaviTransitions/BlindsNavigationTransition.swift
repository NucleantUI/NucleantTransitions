//
//  BlindsNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen opening behind slats tilted open together. Played backwards when the screen is popped.
    @MainActor
    public static var blinds: ShaderNavigationTransition {
        blinds()
    }

    /// The new screen opening behind slats tilted open together. Played backwards when the screen is popped.
    @MainActor
    public static func blinds(
        count: Double = 10,
        axis: Axis = .horizontal,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.blinds.function,
            arguments: [
                .float("count", Float(max(1, count))),
                .float("vertical", axis == .vertical ? 1 : 0)
            ],
            timing: timing
        )
    }
}
