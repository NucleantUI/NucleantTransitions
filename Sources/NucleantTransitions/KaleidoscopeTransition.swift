//
//  KaleidoscopeTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// The view folded into a turning kaleidoscope that opens out into it.
public struct KaleidoscopeTransition: Transition, Equatable {

    /// Mirrored wedges round the centre.
    public var segments: Double

    public init(segments: Double = 8) {
        self.segments = segments
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .kaleidoscope,
            progress: phase.progress,
            arguments: [
                .float("segments", Float(max(2, segments)))
            ]
        ))
    }
}

extension Transition where Self == KaleidoscopeTransition {

    /// The view folded into a turning kaleidoscope that opens out into it.
    public static var kaleidoscope: KaleidoscopeTransition {
        KaleidoscopeTransition()
    }

    /// The view folded into a turning kaleidoscope that opens out into it.
    public static func kaleidoscope(segments: Double = 8) -> KaleidoscopeTransition {
        KaleidoscopeTransition(segments: segments)
    }
}

extension AnyTransition {

    /// The view folded into a turning kaleidoscope that opens out into it.
    public static var kaleidoscope: AnyTransition {
        AnyTransition(KaleidoscopeTransition())
    }

    /// The view folded into a turning kaleidoscope that opens out into it.
    public static func kaleidoscope(segments: Double = 8) -> AnyTransition {
        AnyTransition(KaleidoscopeTransition(segments: segments))
    }
}
