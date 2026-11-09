//
//  ClockWipeNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// A hand sweeping clockwise round the screen's centre, the new screen behind it. Played backwards when the screen is popped.
    @MainActor
    public static var clockWipe: ShaderNavigationTransition {
        clockWipe()
    }

    /// A hand sweeping clockwise round the screen's centre, the new screen behind it. Played backwards when the screen is popped.
    @MainActor
    public static func clockWipe(
        startAngle: Angle = .degrees(-90),
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.clockWipe.function,
            arguments: [
                .float("start", Float(startAngle.radians))
            ],
            timing: timing
        )
    }
}
