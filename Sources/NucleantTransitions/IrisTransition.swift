//
//  IrisTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// A circle opening from a point until it covers the view.
public struct IrisTransition: Transition, Equatable {

    /// Where it starts from, in the view's own unit space: (0, 0) its top
    /// leading corner, (1, 1) its bottom trailing one.
    public var center: UnitPoint

    public init(center: UnitPoint = .center) {
        self.center = center
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .iris,
            progress: phase.progress,
            arguments: [
                .float2("center", Float2(center.x, center.y))
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == IrisTransition {

    /// A circle opening from a point until it covers the view.
    public static var iris: IrisTransition {
        IrisTransition()
    }

    /// A circle opening from a point until it covers the view.
    public static func iris(from center: UnitPoint = .center) -> IrisTransition {
        IrisTransition(center: center)
    }
}

extension AnyTransition {

    /// A circle opening from a point until it covers the view.
    public static var iris: AnyTransition {
        AnyTransition(IrisTransition())
    }

    /// A circle opening from a point until it covers the view.
    public static func iris(from center: UnitPoint = .center) -> AnyTransition {
        AnyTransition(IrisTransition(center: center))
    }
}
