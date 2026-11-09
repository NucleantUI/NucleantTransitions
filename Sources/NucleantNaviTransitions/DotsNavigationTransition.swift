//
//  DotsNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// A grid of dots swelling outward from a point until the new screen is whole. Played backwards when the screen is popped.
    @MainActor
    public static var dots: ShaderNavigationTransition {
        dots()
    }

    /// A grid of dots swelling outward from a point until the new screen is whole. Played backwards when the screen is popped.
    @MainActor
    public static func dots(
        dotSize: Double = 24,
        center: UnitPoint = .center,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.dots.function,
            arguments: [
                .float("size", Float(max(2, dotSize))),
                .float2("center", Float2(center.x, center.y))
            ],
            timing: timing
        )
    }
}
