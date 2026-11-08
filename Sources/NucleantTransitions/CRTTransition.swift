//
//  CRTTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// An old television switching on: a bright line opens across, then out to the
/// whole picture, which settles from glare.
public struct CRTTransition: Transition, Equatable {

    public init() {

    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .crt,
            progress: phase.progress,
            arguments: []
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == CRTTransition {

    /// An old television switching on: a bright line opens across, then out to
    /// the whole picture, which settles from glare.
    public static var crt: CRTTransition {
        CRTTransition()
    }
}

extension AnyTransition {

    /// An old television switching on: a bright line opens across, then out to
    /// the whole picture, which settles from glare.
    public static var crt: AnyTransition {
        AnyTransition(CRTTransition())
    }
}
