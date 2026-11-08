//
//  DoorsTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// Two halves of the view sliding in from either side and meeting in the
/// middle.
public struct DoorsTransition: Transition, Equatable {

    /// The way the halves move: `.horizontal` from left and right, `.vertical`
    /// from top and bottom.
    public var axis: Axis

    public init(axis: Axis = .horizontal) {
        self.axis = axis
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .doors,
            progress: phase.progress,
            arguments: [
                .float("vertical", axis == .vertical ? 1 : 0)
            ]
        ))
    }
}

extension Transition where Self == DoorsTransition {

    /// Two halves of the view sliding in from either side and meeting in the
    /// middle.
    public static var doors: DoorsTransition {
        DoorsTransition()
    }

    /// Two halves of the view sliding in from either side and meeting in the
    /// middle.
    public static func doors(axis: Axis = .horizontal) -> DoorsTransition {
        DoorsTransition(axis: axis)
    }
}

extension AnyTransition {

    /// Two halves of the view sliding in from either side and meeting in the
    /// middle.
    public static var doors: AnyTransition {
        AnyTransition(DoorsTransition())
    }

    /// Two halves of the view sliding in from either side and meeting in the
    /// middle.
    public static func doors(axis: Axis = .horizontal) -> AnyTransition {
        AnyTransition(DoorsTransition(axis: axis))
    }
}
