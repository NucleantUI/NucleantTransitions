//
//  BlindsTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// Slats opening together, like a blind tilted open.
public struct BlindsTransition: Transition, Equatable {

    /// How many slats.
    public var count: Double

    /// The way the slats run: `.horizontal` slats are level, `.vertical` ones
    /// upright.
    public var axis: Axis

    public init(count: Double = 10, axis: Axis = .horizontal) {
        self.count = count
        self.axis = axis
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .blinds,
            progress: phase.progress,
            arguments: [
                .float("count", Float(max(1, count))),
                .float("vertical", axis == .vertical ? 1 : 0)
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == BlindsTransition {

    /// Slats opening together, like a blind tilted open.
    public static var blinds: BlindsTransition {
        BlindsTransition()
    }

    /// Slats opening together, like a blind tilted open.
    public static func blinds(count: Double = 10, axis: Axis = .horizontal) -> BlindsTransition {
        BlindsTransition(count: count, axis: axis)
    }
}

extension AnyTransition {

    /// Slats opening together, like a blind tilted open.
    public static var blinds: AnyTransition {
        AnyTransition(BlindsTransition())
    }

    /// Slats opening together, like a blind tilted open.
    public static func blinds(count: Double = 10, axis: Axis = .horizontal) -> AnyTransition {
        AnyTransition(BlindsTransition(count: count, axis: axis))
    }
}
