//
//  SwirlTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// A transition that unwinds the view out of its centre, and winds it back
/// in as it leaves.
public struct SwirlTransition: Transition, Equatable {

    /// How far the middle of the view is wound where it is least shown, in
    /// whole turns. Negative winds the other way.
    public var turns: Double

    public init(turns: Double = 1.5) {
        self.turns = turns
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .swirl,
            progress: phase.progress,
            arguments: [.float("turns", Float(turns))]
        ))
    }
}

extension Transition where Self == SwirlTransition {

    /// The view unwound out of its centre, a turn and a half.
    public static var swirl: SwirlTransition {
        SwirlTransition()
    }

    /// The view unwound out of its centre by `turns` whole turns.
    public static func swirl(turns: Double) -> SwirlTransition {
        SwirlTransition(turns: turns)
    }
}

extension AnyTransition {

    /// The view unwound out of its centre, a turn and a half.
    public static var swirl: AnyTransition {
        AnyTransition(SwirlTransition())
    }

    /// The view unwound out of its centre by `turns` whole turns.
    public static func swirl(turns: Double) -> AnyTransition {
        AnyTransition(SwirlTransition(turns: turns))
    }
}
