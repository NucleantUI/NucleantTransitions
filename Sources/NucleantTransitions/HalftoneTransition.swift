//
//  HalftoneTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// Halftone dots swelling until they merge into the view.
public struct HalftoneTransition: Transition, Equatable {

    /// The distance between dots, in pixels.
    public var dotSize: Double

    public init(dotSize: Double = 12) {
        self.dotSize = dotSize
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .halftone,
            progress: phase.progress,
            arguments: [
                .float("size", Float(max(2, dotSize)))
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == HalftoneTransition {

    /// Halftone dots swelling until they merge into the view.
    public static var halftone: HalftoneTransition {
        HalftoneTransition()
    }

    /// Halftone dots swelling until they merge into the view.
    public static func halftone(dotSize: Double = 12) -> HalftoneTransition {
        HalftoneTransition(dotSize: dotSize)
    }
}

extension AnyTransition {

    /// Halftone dots swelling until they merge into the view.
    public static var halftone: AnyTransition {
        AnyTransition(HalftoneTransition())
    }

    /// Halftone dots swelling until they merge into the view.
    public static func halftone(dotSize: Double = 12) -> AnyTransition {
        AnyTransition(HalftoneTransition(dotSize: dotSize))
    }
}
