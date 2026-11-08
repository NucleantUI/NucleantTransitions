//
//  ZoomBlurTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// The view rushing in from far off, streaked towards a point.
public struct ZoomBlurTransition: Transition, Equatable {

    /// The point it rushes in towards, in the view's own unit space.
    public var center: UnitPoint

    public init(center: UnitPoint = .center) {
        self.center = center
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .zoomBlur,
            progress: phase.progress,
            arguments: [
                .float2("center", Float2(center.x, center.y))
            ]
        ))
    }
}

extension Transition where Self == ZoomBlurTransition {

    /// The view rushing in from far off, streaked towards a point.
    public static var zoomBlur: ZoomBlurTransition {
        ZoomBlurTransition()
    }

    /// The view rushing in from far off, streaked towards a point.
    public static func zoomBlur(from center: UnitPoint = .center) -> ZoomBlurTransition {
        ZoomBlurTransition(center: center)
    }
}

extension AnyTransition {

    /// The view rushing in from far off, streaked towards a point.
    public static var zoomBlur: AnyTransition {
        AnyTransition(ZoomBlurTransition())
    }

    /// The view rushing in from far off, streaked towards a point.
    public static func zoomBlur(from center: UnitPoint = .center) -> AnyTransition {
        AnyTransition(ZoomBlurTransition(center: center))
    }
}
