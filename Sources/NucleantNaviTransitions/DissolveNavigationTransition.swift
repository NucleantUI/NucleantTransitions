//
//  DissolveNavigationTransition.swift
//  NucleantNaviTransitions
//

import NucleantTransitions
import NucleantUI

extension NavigationTransition where Self == ShaderNavigationTransition {

    /// The new screen grown out of noise, the edge of what has formed glowing `edgeColor`. Played backwards when the screen is popped.
    @MainActor
    public static var dissolve: ShaderNavigationTransition {
        dissolve()
    }

    /// The new screen grown out of noise, the edge of what has formed glowing `edgeColor`. Played backwards when the screen is popped.
    @MainActor
    public static func dissolve(
        edgeColor: Color = Color(red: 1, green: 0.55, blue: 0.15),
        timing: ShaderNavigationTransition.Timing = .smooth()
    ) -> ShaderNavigationTransition {
        ShaderNavigationTransition(
            TransitionShader.dissolve.function,
            arguments: [
                .color("edge_color", edgeColor)
            ],
            timing: timing
        )
    }
}
