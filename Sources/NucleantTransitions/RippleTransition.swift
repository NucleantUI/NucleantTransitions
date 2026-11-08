//
//  RippleTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// A transition that reveals the view in a circle growing from a point,
/// rippling just behind its rim, and hides it in the circle shrinking back.
///
/// ```swift
/// Card(slide)
///     .transition(.asymmetric(
///         insertion: .ripple(from: tapped),
///         removal: .opacity
///     ))
/// ```
public struct RippleTransition: Transition, Equatable {

    /// Where the circle grows from, in the view's own unit space: (0, 0)
    /// its top leading corner, (1, 1) its bottom trailing one.
    public var center: UnitPoint

    public init(center: UnitPoint = .center) {
        self.center = center
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .ripple,
            progress: phase.progress,
            arguments: [.float2("center", Float2(center.x, center.y))]
        ))
    }
}

extension Transition where Self == RippleTransition {

    /// A circle growing from the view's centre, rippling at its rim.
    public static var ripple: RippleTransition {
        RippleTransition()
    }

    /// A circle growing from `center`, rippling at its rim — a point in the
    /// view's unit space, such as where it was tapped:
    /// `UnitPoint(x: location.x / size.width, y: location.y / size.height)`.
    public static func ripple(from center: UnitPoint) -> RippleTransition {
        RippleTransition(center: center)
    }
}

extension AnyTransition {

    /// A circle growing from the view's centre, rippling at its rim.
    public static var ripple: AnyTransition {
        AnyTransition(RippleTransition())
    }

    /// A circle growing from `center`, a point in the view's unit space,
    /// rippling at its rim.
    public static func ripple(from center: UnitPoint) -> AnyTransition {
        AnyTransition(RippleTransition(center: center))
    }
}
