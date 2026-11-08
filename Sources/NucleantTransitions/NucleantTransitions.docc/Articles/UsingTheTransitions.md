# Using the transitions

Add the package, attach a transition, and choose how it comes and goes.

## Overview

Each transition in this package conforms to NucleantUI's `Transition`
protocol, so it works wherever `.opacity` or `.slide` does.

### Add the package

Add NucleantTransitions to your package's dependencies, beside NucleantUI:

```swift
dependencies: [
    .package(url: "https://github.com/NucleantUI/NucleantUI", branch: "master"),
    .package(url: "https://github.com/NucleantUI/NucleantTransitions", branch: "master"),
],
targets: [
    .executableTarget(
        name: "MyApp",
        dependencies: [
            .product(name: "NucleantUI", package: "NucleantUI"),
            .product(name: "NucleantTransitions", package: "NucleantTransitions"),
        ]
    ),
]
```

The shaders are PyShader files, compiled to SPIR-V by PyShader's build
plugin while the package builds. There is nothing to set up: the plugin
builds its compiler from source as part of the same build.

### Attach a transition

Put `.transition(_:)` on a view that an `if`, a `switch` or a `ForEach`
inserts and removes, and change what decides it inside `withAnimation`:

```swift
if isShowingDetail {
    DetailCard(item)
        .transition(.pixelate)
}

Button("Show") {
    withAnimation(.easeInOut(duration: 0.8)) { isShowingDetail = true }
}
```

Every transition has a plain spelling with its defaults, and a function
that takes its parameters:

```swift
.transition(.dissolve)
.transition(.dissolve(edgeColor: .cyan))
.transition(.blinds(count: 6, axis: .vertical))
.transition(.motionBlur(from: .trailing))
```

### Grow it from a point

``RippleTransition``, ``IrisTransition``, ``DiamondTransition``,
``InkTransition``, ``DotsTransition`` and ``ZoomBlurTransition`` start from a
point in the view's own unit space: (0, 0) its top leading corner, (1, 1)
its bottom trailing one. To start one where the user tapped, divide the tap
location by the view's size:

```swift
GeometryReader { proxy in
    ZStack {
        ForEach([slides[index]]) { slide in
            Card(slide)
                .transition(.ripple(from: origin))
        }
    }
    .onTapGesture { location in
        origin = UnitPoint(x: location.x / proxy.size.width, y: location.y / proxy.size.height)
        withAnimation(.easeInOut(duration: 1)) { index += 1 }
    }
}
```

### Choose how it leaves

On removal a transition plays backwards: a ripple shrinks back to its
point, a dissolve eats the view away. To leave a different way, pair it
with another transition. A new card that ripples in over an old one that
fades is the most common:

```swift
.transition(.asymmetric(insertion: .ripple(from: origin), removal: .opacity))
```

`combined(with:)` and `animation(_:)` work as they do with any transition:

```swift
.transition(.glitch.combined(with: .scale))
.transition(.crt.animation(.easeOut(duration: 1.2)))
```

### Choose the animation

The shader's progress follows the animation's curve, so the animation
shapes the transition. An ease in and out suits most of them. A spring that
overshoots runs a reveal briefly past the end and back, which the shaders
take as fully shown.

### How they draw

While a view comes or goes it is drawn into a texture and the shader draws
what reaches the screen. The view keeps its layout, its state and its
input throughout. Clip it inside the transition, as `Card` above rounds its
own corners, so the rounding is in the texture.

## See Also

- <doc:WritingAShaderTransition>
- <doc:TransitionGallery>
