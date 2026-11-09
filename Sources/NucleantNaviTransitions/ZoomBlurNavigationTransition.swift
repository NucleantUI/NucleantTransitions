//
//  ZoomBlurNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen rushing in from far off, streaked towards a point. Played backwards when the screen is popped.
    @MainActor
    public static var zoomBlur: ShaderNavigationTransition {
        zoomBlur()
    }

    /// The new screen rushing in from far off, streaked towards a point. Played backwards when the screen is popped.
    @MainActor
    public static func zoomBlur(
        center: UnitPoint = .center,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.zoomBlur.function,
            arguments: [
                .float2("center", Float2(center.x, center.y))
            ],
            timing: timing
        )
    }
}
