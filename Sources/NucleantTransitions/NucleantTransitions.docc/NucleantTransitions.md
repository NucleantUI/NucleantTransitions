# ``NucleantTransitions``

Twenty-nine transitions for NucleantUI, each drawn by a shader: ripples, dissolves, shatters, an old television switching on.

@Metadata {
    @DisplayName("NucleantTransitions")
}

## Overview

@Image(source: "gallery", alt: "The Transition Gallery: a sidebar listing the transitions by group, with the chosen one's description, a duration slider and its code, and a stage where a red card ripples in from the upper right over a blue one.")

NucleantTransitions is a collection of transitions built on NucleantUI's
`Transition` protocol. Each one runs a shader over the view as it is
inserted or removed. The shader reads the view's own pixels, so a
transition can do what moving and fading the view cannot: tear it into
slices, grow it out of noise, ripple it in from where the user tapped.

Attach one as you would any transition:

```swift
import NucleantTransitions
import NucleantUI

@View
struct Slideshow {
    @State private var index = 0
    let slides: [Slide]

    var body: some View {
        ZStack {
            ForEach([slides[index]]) { slide in
                Card(slide)
                    .transition(.dissolve)
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1)) {
                index = (index + 1) % slides.count
            }
        }
    }
}
```

The animation that inserts or removes the view drives the shader, frame by
frame. Once the view is fully shown the shader is switched off, so a view
that has arrived costs nothing and draws as it would without one.

### Navigation transitions

The `NucleantNaviTransitions` library plays the same shaders as a
`NavigationStack`'s transitions. The pushed screen arrives through one, over
the screen below, and leaves through it backwards when popped:

```swift
import NucleantNaviTransitions

.navigationDestination(for: Photo.self) { photo in
    PhotoDetail(photo)
        .navigationTransition(.dissolve)
}
```

Every transition here has a navigation version with the same name and
arguments, plus a `timing` (a smooth 0.6 s by default):
`.iris(center: .topLeading, timing: .smooth(duration: 0.9))`. Each is a
NucleantUI `ShaderNavigationTransition`, and you can make your own with
`.navigationTransition(.shader(_:arguments:timing:))`.

The fastest way to see them is the Transition Gallery, which runs in your
browser: <doc:TransitionGallery>.

## Topics

### Essentials

- <doc:UsingTheTransitions>
- <doc:WritingAShaderTransition>
- <doc:TransitionGallery>

### Reveals

The view shown through a shape that grows until it covers it.

- ``RippleTransition``
- ``IrisTransition``
- ``DiamondTransition``
- ``InkTransition``
- ``DotsTransition``
- ``WipeTransition``
- ``ClockWipeTransition``
- ``BlindsTransition``
- ``CheckerboardTransition``
- ``TilesTransition``

### Motion

The view's pixels travel into place.

- ``SwirlTransition``
- ``DoorsTransition``
- ``StripesTransition``
- ``MeltTransition``
- ``MotionBlurTransition``
- ``ZoomBlurTransition``
- ``ShatterTransition``
- ``KaleidoscopeTransition``
- ``WaveTransition``

### Dissolves

The view forms in place.

- ``DissolveTransition``
- ``SmokeTransition``
- ``PixelateTransition``
- ``HalftoneTransition``
- ``BlurTransition``

### Effects

The view arrives through a look.

- ``GlitchTransition``
- ``ChromaticTransition``
- ``CRTTransition``
- ``FlashTransition``
- ``DevelopTransition``
