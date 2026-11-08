//
//  MeltTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// The view dripping down into place, column by column.
public struct MeltTransition: Transition, Equatable {

    public init() {

    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .melt,
            progress: phase.progress,
            arguments: []
        ))
    }
}

extension Transition where Self == MeltTransition {

    /// The view dripping down into place, column by column.
    public static var melt: MeltTransition {
        MeltTransition()
    }
}

extension AnyTransition {

    /// The view dripping down into place, column by column.
    public static var melt: AnyTransition {
        AnyTransition(MeltTransition())
    }
}
