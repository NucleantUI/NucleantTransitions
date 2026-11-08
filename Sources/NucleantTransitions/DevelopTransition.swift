//
//  DevelopTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// The view developing like a photograph: dark and grey first, its colour and
/// light coming up.
public struct DevelopTransition: Transition, Equatable {

    public init() {

    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .develop,
            progress: phase.progress,
            arguments: []
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == DevelopTransition {

    /// The view developing like a photograph: dark and grey first, its colour
    /// and light coming up.
    public static var develop: DevelopTransition {
        DevelopTransition()
    }
}

extension AnyTransition {

    /// The view developing like a photograph: dark and grey first, its colour
    /// and light coming up.
    public static var develop: AnyTransition {
        AnyTransition(DevelopTransition())
    }
}
