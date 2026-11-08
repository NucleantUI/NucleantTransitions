//
//  DotsTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// A grid of dots swelling outward from a point until they cover the view.
public struct DotsTransition: Transition, Equatable {

    /// The distance between dots, in pixels.
    public var dotSize: Double

    /// Where it starts from, in the view's own unit space: (0, 0) its top
    /// leading corner, (1, 1) its bottom trailing one.
    public var center: UnitPoint

    public init(dotSize: Double = 24, center: UnitPoint = .center) {
        self.dotSize = dotSize
        self.center = center
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .dots,
            progress: phase.progress,
            arguments: [
                .float("size", Float(max(2, dotSize))),
                .float2("center", Float2(center.x, center.y))
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == DotsTransition {

    /// A grid of dots swelling outward from a point until they cover the view.
    public static var dots: DotsTransition {
        DotsTransition()
    }

    /// A grid of dots swelling outward from a point until they cover the view.
    public static func dots(dotSize: Double = 24, from center: UnitPoint = .center) -> DotsTransition {
        DotsTransition(dotSize: dotSize, center: center)
    }
}

extension AnyTransition {

    /// A grid of dots swelling outward from a point until they cover the view.
    public static var dots: AnyTransition {
        AnyTransition(DotsTransition())
    }

    /// A grid of dots swelling outward from a point until they cover the view.
    public static func dots(dotSize: Double = 24, from center: UnitPoint = .center) -> AnyTransition {
        AnyTransition(DotsTransition(dotSize: dotSize, center: center))
    }
}
