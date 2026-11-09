//
//  PixelateNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen arriving as coarse blocks sharpening into it. Played backwards when the screen is popped.
    @MainActor
    public static var pixelate: ShaderNavigationTransition {
        pixelate()
    }

    /// The new screen arriving as coarse blocks sharpening into it. Played backwards when the screen is popped.
    @MainActor
    public static func pixelate(
        blockSize: Double = 48,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.pixelate.function,
            arguments: [
                .float("block", Float(max(1, blockSize)))
            ],
            timing: timing
        )
    }
}
