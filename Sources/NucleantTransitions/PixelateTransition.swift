//
//  PixelateTransition.swift
//  NucleantTransitions
//

import NucleantUI

/// A transition that brings the view in as coarse blocks sharpening into
/// its pixels, and takes it out as the blocks grow and fade.
public struct PixelateTransition: Transition, Equatable {

    /// The size of the blocks where the view is least shown, in pixels.
    public var blockSize: Double

    public init(blockSize: Double = 48) {
        self.blockSize = blockSize
    }

    public func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(ShaderTransitionEffect(
            shader: .pixelate,
            progress: phase.progress,
            arguments: [.float("block", Float(max(1, blockSize)))]
        ))
    }

    /// It blurs into place; nothing moves.
    public static let properties = TransitionProperties(hasMotion: false)
}

extension Transition where Self == PixelateTransition {

    /// The view in 48-pixel blocks, sharpening as it comes in.
    public static var pixelate: PixelateTransition {
        PixelateTransition()
    }

    /// The view in blocks of up to `blockSize` pixels, sharpening as it
    /// comes in.
    public static func pixelate(blockSize: Double) -> PixelateTransition {
        PixelateTransition(blockSize: blockSize)
    }
}

extension AnyTransition {

    /// The view in 48-pixel blocks, sharpening as it comes in.
    public static var pixelate: AnyTransition {
        AnyTransition(PixelateTransition())
    }

    /// The view in blocks of up to `blockSize` pixels, sharpening as it
    /// comes in.
    public static func pixelate(blockSize: Double) -> AnyTransition {
        AnyTransition(PixelateTransition(blockSize: blockSize))
    }
}
