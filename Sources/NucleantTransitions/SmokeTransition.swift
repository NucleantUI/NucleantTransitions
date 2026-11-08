//
//  SmokeTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// The view gathering out of drifting smoke.
public struct SmokeTransition: Transition, Equatable {

    public init() {

    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .smoke,
            progress: phase.progress,
            arguments: []
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == SmokeTransition {

    /// The view gathering out of drifting smoke.
    public static var smoke: SmokeTransition {
        SmokeTransition()
    }
}

extension AnyTransition {

    /// The view gathering out of drifting smoke.
    public static var smoke: AnyTransition {
        AnyTransition(SmokeTransition())
    }
}
