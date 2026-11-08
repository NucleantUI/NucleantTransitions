//
//  CheckerboardTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// Squares growing out of a checkerboard, one colour of square and then the
/// other.
public struct CheckerboardTransition: Transition, Equatable {

    /// Squares along the view's shorter side.
    public var cells: Double

    public init(cells: Double = 8) {
        self.cells = cells
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .checkerboard,
            progress: phase.progress,
            arguments: [
                .float("cells", Float(max(1, cells)))
            ]
        ))
    }

    /// It changes in place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == CheckerboardTransition {

    /// Squares growing out of a checkerboard, one colour of square and then the
    /// other.
    public static var checkerboard: CheckerboardTransition {
        CheckerboardTransition()
    }

    /// Squares growing out of a checkerboard, one colour of square and then the
    /// other.
    public static func checkerboard(cells: Double = 8) -> CheckerboardTransition {
        CheckerboardTransition(cells: cells)
    }
}

extension AnyTransition {

    /// Squares growing out of a checkerboard, one colour of square and then the
    /// other.
    public static var checkerboard: AnyTransition {
        AnyTransition(CheckerboardTransition())
    }

    /// Squares growing out of a checkerboard, one colour of square and then the
    /// other.
    public static func checkerboard(cells: Double = 8) -> AnyTransition {
        AnyTransition(CheckerboardTransition(cells: cells))
    }
}
