# Transition Gallery

Every transition in the package, live: pick one and the next card arrives with it.

@Metadata {
    @CallToAction(url: "/NucleantTransitions/gallery/", purpose: link, label: "Run in your browser")
    @PageImage(purpose: card, source: "gallery", alt: "The Transition Gallery: a sidebar listing the transitions by group, and a stage where a red card ripples in over a blue one.")
}

## Overview

@Image(source: "gallery", alt: "The Transition Gallery: a sidebar listing the transitions by group, with the chosen one's description, a duration slider and its code, and a stage where a red card ripples in from the upper right over a blue one.")

The gallery is the package's showcase app: a slideshow of five cards. Its
sidebar lists the twenty-nine transitions in four groups. Choosing one brings
on the next card with it, and below the list are what it does, how long it
takes, and the Swift that makes what the stage shows.

What it shows:

- Each card arriving with the transition chosen, under an ease in and out
  as long as the duration slider says.
- Transitions that start from a point (ripple, iris, diamond, ink, dots and
  zoom blur) starting from wherever you click the card.
- The card being replaced fading out under the new one, or, with the toggle
  off, leaving with the same transition played backwards.
- The code updating as you choose: the transition, the point you clicked,
  and the animation.

Click the card, or press the arrow keys, to step through the deck.

## Run it

The gallery runs in your browser from the button above: it is the same
Swift code, built for WebAssembly and drawn with WebGPU. You need a browser
with WebGPU: Chrome or Edge 113 or later, Safari 26, or Firefox 141 on
Windows.

To run it yourself, it is the package's `TransitionGallery` product:

```sh
git clone https://github.com/NucleantUI/NucleantTransitions
cd NucleantTransitions
swift run TransitionGallery
```

## See Also

- <doc:UsingTheTransitions>
