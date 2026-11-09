# NucleantTransitions

Transitions for [NucleantUI](https://github.com/NucleantUI/NucleantUI) drawn
by shaders. Each one runs a [PyShader](https://github.com/NucleantUI/PyShader)
effect over the view as it arrives or leaves. The effect reads the view's
pixels with `layer(uv)`, and the change that inserts or removes the view
animates the effect's progress.

Documentation, and the gallery running in your browser:
https://nucleantui.github.io/NucleantTransitions/

| Transition | What it does |
|---|---|
| `.ripple`, `.ripple(from:)` | A circle grows from a point until it covers the view, rippling just behind its rim. |
| `.dissolve`, `.dissolve(edgeColor:)` | The view forms out of noise, the edge of what has formed glowing. |
| `.pixelate`, `.pixelate(blockSize:)` | Coarse blocks sharpen into the view's pixels. |
| `.swirl`, `.swirl(turns:)` | The view unwinds out of its centre. |
| `.glitch`, `.glitch(strength:)` | Torn slices jump sideways, colour channels pulled apart, and settle. |
| `.wipe(angle:feather:)`, `.wipe(from:)` | A soft edge sweeps across. |
| `.clockWipe(startAngle:)` | A hand sweeps round the centre. |
| `.iris(from:)` | A clean circle opens from a point. |
| `.diamond(from:)` | A diamond opens from a point. |
| `.ink(from:)` | Ink soaks outward from a point, its edge ragged. |
| `.dots(dotSize:from:)` | A grid of dots swells outward from a point until they merge. |
| `.blinds(count:axis:)` | Slats open together. |
| `.checkerboard(cells:)` | Squares grow out of a checkerboard, one colour then the other. |
| `.tiles(cells:)` | Tiles fade in one by one, in no order. |
| `.doors(axis:)` | Two halves slide in from either side and meet. |
| `.stripes(count:)` | Strips slide in from alternate sides. |
| `.melt` | The view drips down into place, column by column. |
| `.motionBlur(from:)` | The view slides in from an edge, smeared as it moves. |
| `.zoomBlur(from:)` | The view rushes in from far off, streaked towards a point. |
| `.shatter(cells:)` | Shards fly in, turning, and settle each in its own time. |
| `.kaleidoscope(segments:)` | A turning kaleidoscope opens out into the view. |
| `.wave(amplitude:)` | The view rolls in on waves that flatten. |
| `.smoke` | The view gathers out of drifting smoke. |
| `.halftone(dotSize:)` | Halftone dots swell until they merge into the view. |
| `.blur(radius:)` | The view comes into focus. |
| `.chromatic(strength:)` | Colour channels fly apart and come back together. |
| `.crt` | An old television switching on. |
| `.flash(color:)` | A flash of colour fades to show the view. |
| `.develop` | The view develops like a photograph. |

```swift
import NucleantTransitions
import NucleantUI

Card(slide)
    .transition(.asymmetric(
        insertion: .ripple(from: tapped),
        removal: .opacity
    ))

withAnimation(.easeInOut(duration: 1)) { index += 1 }
```

Each one is also a `Transition` type of its own (`RippleTransition`,
`DissolveTransition`, …), so `.transition(.dissolve)` takes no erasure and
`.combined(with:)` and `.animation(_:)` work as with any transition.

## Navigation transitions

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

## Writing your own

A shader transition is an `Animatable` `ViewModifier` with its progress as
`animatableData`. Its `body` runs `.shader(_:arguments:)` with that progress,
and a `Transition` sets the progress from the phase. The shaders here, in
`Shaders/`, take `progress` first: 0 with nothing of the view shown, 1 with
all of it. At 1 the shader is switched off, so a view that is simply shown
draws as it would without the transition.

## Gallery

```sh
swift run TransitionGallery
```

A slideshow of cards, each arriving with the transition picked in the
sidebar. Click a card to bring on the next one from where you clicked.

```sh
swift run NaviTransitionGallery
```

A navigation stack where every screen arrives through the transition it is
named for. Pick one from the grid, go on to the next from each screen, and
go back to see it played in reverse.

## Requirements

The shaders are compiled to SPIR-V by PyShader's build plugin as the library
builds, as `pyshader.toml` lists them.
