//
//  CRTNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen switching on like an old television: a bright line opening across, then out to the full screen. Played backwards when the screen is popped.
    @MainActor
    public static var crt: ShaderNavigationTransition {
        crt()
    }

    /// The new screen switching on like an old television: a bright line opening across, then out to the full screen. Played backwards when the screen is popped.
    @MainActor
    public static func crt(
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.crt.function,
            timing: timing
        )
    }
}
