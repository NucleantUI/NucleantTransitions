# Writing a shader transition

Make a transition of your own from a PyShader shader.

## Overview

Every transition in this package is the same three pieces: a shader that
draws the view at some progress, a modifier that animates the progress,
and a `Transition` that sets it from the phase. You can make your own the
same way, in your own package.

### Write the shader

A transition's shader is a PyShader compute effect. It reads the view with
`layer(uv)` and takes `progress` as an argument: 0 with nothing of the view
shown, 1 with all of it. This one wipes the view in from the bottom:

```py
from pyshader import *


def main(uv: float2, progress: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    shown = 1.0 - smoothstep(t - 0.05, t, uv.y)
    return layer(uv) * shown
```

`uv` runs from (0, 0) at the bottom leading corner to (1, 1) at the top
trailing one. `resolution`, the view's size in pixels, is there too if the
shader needs it.

### Compile it with the package

List the shader in a `pyshader.toml` at the root of your package, with the
arguments it takes in the order you will pass them:

```toml
[Rise]
source = "Shaders/Rise.py"
target = "compute"
content-top-down = true
arguments = ["progress:float"]
```

and apply PyShader's build plugin to the target:

```swift
.target(
    name: "MyTransitions",
    dependencies: [.product(name: "NucleantUI", package: "NucleantUI")],
    plugins: [.plugin(name: "PyShaderBuildPlugin", package: "PyShader")]
)
```

The compiled module is one of the target's resources, `Rise.spv`.

### Animate the progress

An `Animatable` modifier with the progress as its `animatableData` runs the
shader over the view. Switch the shader off when the progress reaches 1, so
a view that has arrived draws as it would without it:

```swift
struct RiseEffect: ViewModifier, Animatable {
    static let function: ShaderFunction = {
        let url = Bundle.module.url(forResource: "Rise", withExtension: "spv")!
        let data = try! Data(contentsOf: url)
        return ShaderFunction(spirv: data.withUnsafeBytes { Array($0.bindMemory(to: UInt32.self)) }, isAnimated: false)
    }()

    var progress: Double

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        content.shader(
            Self.function,
            arguments: [.float("progress", Float(progress))],
            isEnabled: progress < 1
        )
    }
}
```

`isAnimated: false` says the shader reads neither the clock nor the
pointer, so it draws again only when its progress moves.

### Make it a transition

The transition shows all of the view in `identity` and none of it on either
side:

```swift
struct RiseTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content.modifier(RiseEffect(progress: phase.isIdentity ? 1 : 0))
    }
}

extension Transition where Self == RiseTransition {
    static var rise: RiseTransition { RiseTransition() }
}
```

Now `.transition(.rise)` wipes a view in from the bottom as it is inserted,
and out the same way as it is removed.

## See Also

- <doc:UsingTheTransitions>
