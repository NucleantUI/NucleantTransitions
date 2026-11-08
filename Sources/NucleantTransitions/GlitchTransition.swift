//
//  GlitchTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// A transition that tears the view into slices jumping sideways, their
/// colour channels pulled apart, settling as it comes in.
public struct GlitchTransition: Transition, Equatable {

    /// How far a slice can jump where the view is least shown, as a
    /// fraction of its width.
    public var strength: Double

    public init(strength: Double = 0.25) {
        self.strength = strength
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .glitch,
            progress: phase.progress,
            arguments: [.float("strength", Float(strength))]
        ))
    }
}

extension Transition where Self == GlitchTransition {

    /// The view torn into slices that settle as it comes in.
    public static var glitch: GlitchTransition {
        GlitchTransition()
    }

    /// The view torn into slices jumping up to `strength` of its width.
    public static func glitch(strength: Double) -> GlitchTransition {
        GlitchTransition(strength: strength)
    }
}

extension AnyTransition {

    /// The view torn into slices that settle as it comes in.
    public static var glitch: AnyTransition {
        AnyTransition(GlitchTransition())
    }

    /// The view torn into slices jumping up to `strength` of its width.
    public static func glitch(strength: Double) -> AnyTransition {
        AnyTransition(GlitchTransition(strength: strength))
    }
}
