//
//  TilesTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// Square tiles of the view fading in one by one, in no order.
public struct TilesTransition: Transition, Equatable {

    /// Tiles along the view's shorter side.
    public var cells: Double

    public init(cells: Double = 10) {
        self.cells = cells
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .tiles,
            progress: phase.progress,
            arguments: [
                .float("cells", Float(max(1, cells)))
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == TilesTransition {

    /// Square tiles of the view fading in one by one, in no order.
    public static var tiles: TilesTransition {
        TilesTransition()
    }

    /// Square tiles of the view fading in one by one, in no order.
    public static func tiles(cells: Double = 10) -> TilesTransition {
        TilesTransition(cells: cells)
    }
}

extension AnyTransition {

    /// Square tiles of the view fading in one by one, in no order.
    public static var tiles: AnyTransition {
        AnyTransition(TilesTransition())
    }

    /// Square tiles of the view fading in one by one, in no order.
    public static func tiles(cells: Double = 10) -> AnyTransition {
        AnyTransition(TilesTransition(cells: cells))
    }
}
