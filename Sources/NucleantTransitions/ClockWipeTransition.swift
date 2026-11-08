//
//  ClockWipeTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// A hand sweeping clockwise round the view's centre, showing it behind.
public struct ClockWipeTransition: Transition, Equatable {

    /// Where the hand starts, clockwise from trailing as the screen is seen:
    /// -90° is twelve o'clock.
    public var startAngle: Angle

    public init(startAngle: Angle = .degrees(-90)) {
        self.startAngle = startAngle
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .clockWipe,
            progress: phase.progress,
            arguments: [
                .float("start", Float(startAngle.radians))
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == ClockWipeTransition {

    /// A hand sweeping clockwise round the view's centre, showing it behind.
    public static var clockWipe: ClockWipeTransition {
        ClockWipeTransition()
    }

    /// A hand sweeping clockwise round the view's centre, showing it behind.
    public static func clockWipe(startAngle: Angle = .degrees(-90)) -> ClockWipeTransition {
        ClockWipeTransition(startAngle: startAngle)
    }
}

extension AnyTransition {

    /// A hand sweeping clockwise round the view's centre, showing it behind.
    public static var clockWipe: AnyTransition {
        AnyTransition(ClockWipeTransition())
    }

    /// A hand sweeping clockwise round the view's centre, showing it behind.
    public static func clockWipe(startAngle: Angle = .degrees(-90)) -> AnyTransition {
        AnyTransition(ClockWipeTransition(startAngle: startAngle))
    }
}
