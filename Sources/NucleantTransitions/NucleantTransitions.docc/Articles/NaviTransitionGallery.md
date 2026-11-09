# Navigation Transition Gallery

Every transition as a navigation transition, live: push a screen and it arrives through the shader, pop it and it leaves the same way backwards.

@Metadata {
    @CallToAction(url: "/NucleantTransitions/navi-gallery/", purpose: link, label: "Run in your browser")
    @PageImage(purpose: card, source: "navi-gallery", alt: "A green Dissolve screen forming out of noise over the grid of transitions it was pushed from.")
}

## Overview

@Image(source: "navi-gallery", alt: "A green Dissolve screen forming out of noise over the grid of transitions it was pushed from.")

The gallery is a `NavigationStack` whose front screen is a grid of the
twenty-nine transitions in `NucleantNaviTransitions`. Choosing one pushes a
screen that arrives through that shader. Each screen links to the next
transition, so a stack several screens deep can be built up and popped back
down, each screen leaving through the transition it arrived with.

Every screen is pushed with its transition's plain spelling:

```swift
import NucleantNaviTransitions

.navigationDestination(for: NaviKind.self) { kind in
    KindScreen(kind: kind)
        .navigationTransition(kind.transition)   // .dissolve, .iris, .wipe, …
}
```

## Run it

The gallery runs in your browser from the button above: it is the same
Swift code, built for WebAssembly and drawn with WebGPU. You need a browser
with WebGPU: Chrome or Edge 113 or later, Safari 26, or Firefox 141 on
Windows.

To run it yourself, it is the package's `NaviTransitionGallery` product:

```sh
git clone https://github.com/NucleantUI/NucleantTransitions
cd NucleantTransitions
swift run NaviTransitionGallery
```

## See Also

- <doc:TransitionGallery>
