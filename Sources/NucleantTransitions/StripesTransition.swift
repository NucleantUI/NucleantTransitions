//
//  StripesTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// Level strips of the view sliding in from alternate sides, one after another.
public struct StripesTransition: Transition, Equatable {

    /// How many strips.
    public var count: Double

    public init(count: Double = 8) {
        self.count = count
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .stripes,
            progress: phase.progress,
            arguments: [
                .float("count", Float(max(1, count)))
            ]
        ))
    }
}

extension Transition where Self == StripesTransition {

    /// Level strips of the view sliding in from alternate sides, one after
    /// another.
    public static var stripes: StripesTransition {
        StripesTransition()
    }

    /// Level strips of the view sliding in from alternate sides, one after
    /// another.
    public static func stripes(count: Double = 8) -> StripesTransition {
        StripesTransition(count: count)
    }
}

extension AnyTransition {

    /// Level strips of the view sliding in from alternate sides, one after
    /// another.
    public static var stripes: AnyTransition {
        AnyTransition(StripesTransition())
    }

    /// Level strips of the view sliding in from alternate sides, one after
    /// another.
    public static func stripes(count: Double = 8) -> AnyTransition {
        AnyTransition(StripesTransition(count: count))
    }
}
