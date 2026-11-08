//
//  DissolveTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// A transition that grows the view out of noise, the edge of what has
/// formed glowing, and eats it away the same way.
///
/// ```swift
/// Text("Welcome back")
///     .transition(.dissolve(edgeColor: .orange))
/// ```
public struct DissolveTransition: Transition, Equatable {

    /// The glow along the edge of what is shown. Its opacity is how
    /// strongly it shows; a clear colour dissolves with no glow at all.
    public var edgeColor: Color

    public init(edgeColor: Color = Color(red: 1, green: 0.55, blue: 0.15)) {
        self.edgeColor = edgeColor
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .dissolve,
            progress: phase.progress,
            arguments: [.color("edge_color", edgeColor)]
        ))
    }

    /// It fades in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == DissolveTransition {

    /// The view grown out of noise, its forming edge glowing orange.
    public static var dissolve: DissolveTransition {
        DissolveTransition()
    }

    /// The view grown out of noise, its forming edge glowing `edgeColor`.
    public static func dissolve(edgeColor: Color) -> DissolveTransition {
        DissolveTransition(edgeColor: edgeColor)
    }
}

extension AnyTransition {

    /// The view grown out of noise, its forming edge glowing orange.
    public static var dissolve: AnyTransition {
        AnyTransition(DissolveTransition())
    }

    /// The view grown out of noise, its forming edge glowing `edgeColor`.
    public static func dissolve(edgeColor: Color) -> AnyTransition {
        AnyTransition(DissolveTransition(edgeColor: edgeColor))
    }
}
