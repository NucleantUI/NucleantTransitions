//
//  WaveNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen rolling in on waves that flatten as it settles. Played backwards when the screen is popped.
    @MainActor
    public static var wave: ShaderNavigationTransition {
        wave()
    }

    /// The new screen rolling in on waves that flatten as it settles. Played backwards when the screen is popped.
    @MainActor
    public static func wave(
        amplitude: Double = 0.08,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.wave.function,
            arguments: [
                .float("amplitude", Float(amplitude))
            ],
            timing: timing
        )
    }
}
