//
//  WaveTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// The view rolling in on waves that flatten as it settles.
public struct WaveTransition: Transition, Equatable {

    /// How far the waves push the view at the start, as a fraction of its size.
    public var amplitude: Double

    public init(amplitude: Double = 0.08) {
        self.amplitude = amplitude
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .wave,
            progress: phase.progress,
            arguments: [
                .float("amplitude", Float(amplitude))
            ]
        ))
    }
}

extension Transition where Self == WaveTransition {

    /// The view rolling in on waves that flatten as it settles.
    public static var wave: WaveTransition {
        WaveTransition()
    }

    /// The view rolling in on waves that flatten as it settles.
    public static func wave(amplitude: Double = 0.08) -> WaveTransition {
        WaveTransition(amplitude: amplitude)
    }
}

extension AnyTransition {

    /// The view rolling in on waves that flatten as it settles.
    public static var wave: AnyTransition {
        AnyTransition(WaveTransition())
    }

    /// The view rolling in on waves that flatten as it settles.
    public static func wave(amplitude: Double = 0.08) -> AnyTransition {
        AnyTransition(WaveTransition(amplitude: amplitude))
    }
}
