//
//  WipeTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// A soft edge sweeping across the view, showing it behind.
public struct WipeTransition: Transition, Equatable {

    /// The way the edge travels, clockwise from trailing as the screen is seen:
    /// `.zero` sweeps from the leading edge to the trailing one, 90° from the
    /// top down.
    public var angle: Angle

    /// The width of the soft edge, as a fraction of the view.
    public var feather: Double

    public init(angle: Angle = .zero, feather: Double = 0.15) {
        self.angle = angle
        self.feather = feather
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .wipe,
            progress: phase.progress,
            arguments: [
                .float("angle", Float(angle.radians)),
                .float("feather", Float(max(0, feather)))
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == WipeTransition {

    /// A soft edge sweeping across the view, showing it behind.
    public static var wipe: WipeTransition {
        WipeTransition()
    }

    /// A soft edge sweeping across the view, showing it behind.
    public static func wipe(angle: Angle = .zero, feather: Double = 0.15) -> WipeTransition {
        WipeTransition(angle: angle, feather: feather)
    }
    /// A soft edge sweeping in from `edge`, showing the view behind it.
    public static func wipe(from edge: Edge) -> WipeTransition {
        WipeTransition(angle: edge.inward)
    }
}

extension AnyTransition {

    /// A soft edge sweeping across the view, showing it behind.
    public static var wipe: AnyTransition {
        AnyTransition(WipeTransition())
    }

    /// A soft edge sweeping across the view, showing it behind.
    public static func wipe(angle: Angle = .zero, feather: Double = 0.15) -> AnyTransition {
        AnyTransition(WipeTransition(angle: angle, feather: feather))
    }
    /// A soft edge sweeping in from `edge`, showing the view behind it.
    public static func wipe(from edge: Edge) -> AnyTransition {
        AnyTransition(WipeTransition(angle: edge.inward))
    }
}
