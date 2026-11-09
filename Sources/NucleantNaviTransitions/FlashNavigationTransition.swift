//
//  FlashNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// A flash of `color` fading to show the new screen. Played backwards when the screen is popped.
    @MainActor
    public static var flash: ShaderNavigationTransition {
        flash()
    }

    /// A flash of `color` fading to show the new screen. Played backwards when the screen is popped.
    @MainActor
    public static func flash(
        color: Color = .white,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.flash.function,
            arguments: [
                .color("color", color)
            ],
            timing: timing
        )
    }
}
