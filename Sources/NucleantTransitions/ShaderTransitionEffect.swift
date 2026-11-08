//
//  ShaderTransitionEffect.swift
//  NucleantTransitions
//
//  What every transition here puts on its view: a shader run over the
//  view's pixels at some progress, 0 with nothing of the view shown and 1
//  with all of it. The progress is the modifier's animatable data, so the
//  change that inserts or removes the view carries it from one end to the
//  other, frame by frame, under whatever animation that change has — the
//  shader only says what each value looks like.
//

import NucleantUI

/// `shader` over the view at `progress`, with `arguments` after it.
struct ShaderTransitionEffect: ViewModifier, Animatable {

    let shader: TransitionShader

    /// 0: nothing of the view shown. 1: all of it, as it is.
    var progress: Double

    /// The shader's own arguments, in the order `pyshader.toml` declares
    /// them after `progress`.
    let arguments: [ShaderArgument]

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        // Once the view is all there the shader is switched off: the view
        // draws as it would with no transition, and its identity and state
        // are untouched either way.
        content.shader(
            shader.function,
            arguments: [.float("progress", Float(progress))] + arguments,
            isEnabled: progress < 1
        )
    }
}

extension TransitionPhase {

    /// How much of the view a shader transition shows in this phase: all of
    /// it in `identity`, none of it on either side.
    var progress: Double {
        isIdentity ? 1 : 0
    }
}
