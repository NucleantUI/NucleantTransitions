//
//  ShatterTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// Shards flying in from around the view, turning as they come, and settling
/// into it each in its own time.
public struct ShatterTransition: Transition, Equatable {

    /// Roughly how many shards along the view's shorter side.
    public var cells: Double

    public init(cells: Double = 6) {
        self.cells = cells
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .shatter,
            progress: phase.progress,
            arguments: [
                .float("cells", Float(max(1, cells)))
            ]
        ))
    }
}

extension Transition where Self == ShatterTransition {

    /// Shards flying in from around the view, turning as they come, and
    /// settling into it each in its own time.
    public static var shatter: ShatterTransition {
        ShatterTransition()
    }

    /// Shards flying in from around the view, turning as they come, and
    /// settling into it each in its own time.
    public static func shatter(cells: Double = 6) -> ShatterTransition {
        ShatterTransition(cells: cells)
    }
}

extension AnyTransition {

    /// Shards flying in from around the view, turning as they come, and
    /// settling into it each in its own time.
    public static var shatter: AnyTransition {
        AnyTransition(ShatterTransition())
    }

    /// Shards flying in from around the view, turning as they come, and
    /// settling into it each in its own time.
    public static func shatter(cells: Double = 6) -> AnyTransition {
        AnyTransition(ShatterTransition(cells: cells))
    }
}
