//
//  WipeNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// A soft edge sweeping across, the new screen behind it. Played backwards when the screen is popped.
    @MainActor
    public static var wipe: ShaderNavigationTransition {
        wipe()
    }

    /// A soft edge sweeping across, the new screen behind it. Played backwards when the screen is popped.
    @MainActor
    public static func wipe(
        angle: Angle = .zero,
        feather: Double = 0.15,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.wipe.function,
            arguments: [
                .float("angle", Float(angle.radians)),
                .float("feather", Float(max(0, feather)))
            ],
            timing: timing
        )
    }
}
