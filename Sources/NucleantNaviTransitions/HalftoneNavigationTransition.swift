//
//  HalftoneNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// Halftone dots swelling until they merge into the new screen. Played backwards when the screen is popped.
    @MainActor
    public static var halftone: ShaderNavigationTransition {
        halftone()
    }

    /// Halftone dots swelling until they merge into the new screen. Played backwards when the screen is popped.
    @MainActor
    public static func halftone(
        dotSize: Double = 12,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.halftone.function,
            arguments: [
                .float("size", Float(max(2, dotSize)))
            ],
            timing: timing
        )
    }
}
