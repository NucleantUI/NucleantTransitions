//
//  FlashTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// A flash of colour fading to show the view.
public struct FlashTransition: Transition, Equatable {

    /// The flash. Its opacity is how strongly it shows.
    public var color: Color

    public init(color: Color = .white) {
        self.color = color
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .flash,
            progress: phase.progress,
            arguments: [
                .color("color", color)
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == FlashTransition {

    /// A flash of colour fading to show the view.
    public static var flash: FlashTransition {
        FlashTransition()
    }

    /// A flash of colour fading to show the view.
    public static func flash(color: Color = .white) -> FlashTransition {
        FlashTransition(color: color)
    }
}

extension AnyTransition {

    /// A flash of colour fading to show the view.
    public static var flash: AnyTransition {
        AnyTransition(FlashTransition())
    }

    /// A flash of colour fading to show the view.
    public static func flash(color: Color = .white) -> AnyTransition {
        AnyTransition(FlashTransition(color: color))
    }
}
