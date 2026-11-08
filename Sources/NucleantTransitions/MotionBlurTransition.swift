//
//  MotionBlurTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// The view sliding in from an edge, smeared along the way it moves, and out
/// through the same edge.
public struct MotionBlurTransition: Transition, Equatable {

    /// The edge it slides in from.
    public var edge: Edge

    public init(edge: Edge = .leading) {
        self.edge = edge
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .motionBlur,
            progress: phase.progress,
            arguments: [
                .float2("direction", edge.travel)
            ]
        ))
    }
}

extension Transition where Self == MotionBlurTransition {

    /// The view sliding in from an edge, smeared along the way it moves, and
    /// out through the same edge.
    public static var motionBlur: MotionBlurTransition {
        MotionBlurTransition()
    }

    /// The view sliding in from an edge, smeared along the way it moves, and
    /// out through the same edge.
    public static func motionBlur(from edge: Edge = .leading) -> MotionBlurTransition {
        MotionBlurTransition(edge: edge)
    }
}

extension AnyTransition {

    /// The view sliding in from an edge, smeared along the way it moves, and
    /// out through the same edge.
    public static var motionBlur: AnyTransition {
        AnyTransition(MotionBlurTransition())
    }

    /// The view sliding in from an edge, smeared along the way it moves, and
    /// out through the same edge.
    public static func motionBlur(from edge: Edge = .leading) -> AnyTransition {
        AnyTransition(MotionBlurTransition(edge: edge))
    }
}
