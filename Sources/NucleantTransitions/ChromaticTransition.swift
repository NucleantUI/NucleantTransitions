//
//  ChromaticTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// The view's colour channels flying apart from its centre and coming back
/// together.
public struct ChromaticTransition: Transition, Equatable {

    /// How far the channels spread at the start, as a fraction of the view's
    /// size.
    public var strength: Double

    public init(strength: Double = 0.12) {
        self.strength = strength
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .chromatic,
            progress: phase.progress,
            arguments: [
                .float("strength", Float(strength))
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == ChromaticTransition {

    /// The view's colour channels flying apart from its centre and coming back
    /// together.
    public static var chromatic: ChromaticTransition {
        ChromaticTransition()
    }

    /// The view's colour channels flying apart from its centre and coming back
    /// together.
    public static func chromatic(strength: Double = 0.12) -> ChromaticTransition {
        ChromaticTransition(strength: strength)
    }
}

extension AnyTransition {

    /// The view's colour channels flying apart from its centre and coming back
    /// together.
    public static var chromatic: AnyTransition {
        AnyTransition(ChromaticTransition())
    }

    /// The view's colour channels flying apart from its centre and coming back
    /// together.
    public static func chromatic(strength: Double = 0.12) -> AnyTransition {
        AnyTransition(ChromaticTransition(strength: strength))
    }
}
