//
//  BlurTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// The view coming into focus.
public struct BlurTransition: Transition, Equatable {

    /// How blurred it starts, in pixels.
    public var radius: Double

    public init(radius: Double = 24) {
        self.radius = radius
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .blur,
            progress: phase.progress,
            arguments: [
                .float("radius", Float(max(0, radius)))
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == BlurTransition {

    /// The view coming into focus.
    public static var blur: BlurTransition {
        BlurTransition()
    }

    /// The view coming into focus.
    public static func blur(radius: Double = 24) -> BlurTransition {
        BlurTransition(radius: radius)
    }
}

extension AnyTransition {

    /// The view coming into focus.
    public static var blur: AnyTransition {
        AnyTransition(BlurTransition())
    }

    /// The view coming into focus.
    public static func blur(radius: Double = 24) -> AnyTransition {
        AnyTransition(BlurTransition(radius: radius))
    }
}
