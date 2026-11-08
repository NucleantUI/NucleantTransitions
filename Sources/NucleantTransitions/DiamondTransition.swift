//
//  DiamondTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// A diamond opening from a point until it covers the view.
public struct DiamondTransition: Transition, Equatable {

    /// Where it starts from, in the view's own unit space: (0, 0) its top
    /// leading corner, (1, 1) its bottom trailing one.
    public var center: UnitPoint

    public init(center: UnitPoint = .center) {
        self.center = center
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .diamond,
            progress: phase.progress,
            arguments: [
                .float2("center", Float2(center.x, center.y))
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == DiamondTransition {

    /// A diamond opening from a point until it covers the view.
    public static var diamond: DiamondTransition {
        DiamondTransition()
    }

    /// A diamond opening from a point until it covers the view.
    public static func diamond(from center: UnitPoint = .center) -> DiamondTransition {
        DiamondTransition(center: center)
    }
}

extension AnyTransition {

    /// A diamond opening from a point until it covers the view.
    public static var diamond: AnyTransition {
        AnyTransition(DiamondTransition())
    }

    /// A diamond opening from a point until it covers the view.
    public static func diamond(from center: UnitPoint = .center) -> AnyTransition {
        AnyTransition(DiamondTransition(center: center))
    }
}
