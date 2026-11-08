//
//  InkTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// Ink spreading from a point with a ragged, soaking edge until it covers the
/// view.
public struct InkTransition: Transition, Equatable {

    /// Where it starts from, in the view's own unit space: (0, 0) its top
    /// leading corner, (1, 1) its bottom trailing one.
    public var center: UnitPoint

    public init(center: UnitPoint = .center) {
        self.center = center
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .ink,
            progress: phase.progress,
            arguments: [
                .float2("center", Float2(center.x, center.y))
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == InkTransition {

    /// Ink spreading from a point with a ragged, soaking edge until it covers
    /// the view.
    public static var ink: InkTransition {
        InkTransition()
    }

    /// Ink spreading from a point with a ragged, soaking edge until it covers
    /// the view.
    public static func ink(from center: UnitPoint = .center) -> InkTransition {
        InkTransition(center: center)
    }
}

extension AnyTransition {

    /// Ink spreading from a point with a ragged, soaking edge until it covers
    /// the view.
    public static var ink: AnyTransition {
        AnyTransition(InkTransition())
    }

    /// Ink spreading from a point with a ragged, soaking edge until it covers
    /// the view.
    public static func ink(from center: UnitPoint = .center) -> AnyTransition {
        AnyTransition(InkTransition(center: center))
    }
}
