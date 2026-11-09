//
//  MotionBlurNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen sliding in from `edge`, smeared along the way it moves. Played backwards when the screen is popped.
    @MainActor
    public static var motionBlur: ShaderNavigationTransition {
        motionBlur()
    }

    /// The new screen sliding in from `edge`, smeared along the way it moves. Played backwards when the screen is popped.
    @MainActor
    public static func motionBlur(
        edge: Edge = .trailing,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.motionBlur.function,
            arguments: [
                .float2("direction", edge.travel)
            ],
            timing: timing
        )
    }
}
