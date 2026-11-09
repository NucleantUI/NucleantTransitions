//
//  TilesNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// Square tiles of the new screen fading in one by one, in no order. Played backwards when the screen is popped.
    @MainActor
    public static var tiles: ShaderNavigationTransition {
        tiles()
    }

    /// Square tiles of the new screen fading in one by one, in no order. Played backwards when the screen is popped.
    @MainActor
    public static func tiles(
        cells: Double = 10,
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.tiles.function,
            arguments: [
                .float("cells", Float(max(1, cells)))
            ],
            timing: timing
        )
    }
}
