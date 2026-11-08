//
//  Slideshow.swift
//  TransitionGallery
//
//  The gallery's model: the deck, the card showing, and how the next one
//  arrives — which transition, from where, how long it takes, and what the
//  card it replaces does.
//

import Foundation
import NucleantTransitions
import NucleantUI
import Observation

/// One of the package's transitions.
enum TransitionKind: CaseIterable, Identifiable {
    case ripple, dissolve, pixelate, swirl, glitch

    var id: Self { self }

    var name: String {
        switch self {
        case .ripple:   return "Ripple"
        case .dissolve: return "Dissolve"
        case .pixelate: return "Pixelate"
        case .swirl:    return "Swirl"
        case .glitch:   return "Glitch"
        }
    }

    var summary: String {
        switch self {
        case .ripple:
            return "A circle grows from a point until it covers the card, rippling just behind its rim. Click the card: it grows from where you clicked."
        case .dissolve:
            return "The card forms out of noise, the edge of what has formed glowing."
        case .pixelate:
            return "Coarse blocks sharpen into the card's pixels."
        case .swirl:
            return "The card unwinds out of its centre."
        case .glitch:
            return "Torn slices jump sideways, their colour channels pulled apart, and settle."
        }
    }
}

/// A card in the deck.
struct Slide: Identifiable {
    let id: Int
    let title: String
    let caption: String
    let colors: [Color]

    static let deck = [
        Slide(id: 0, title: "Lagoon", caption: "Still water at first light", colors: [Color(hex: 0x0F4C75), Color(hex: 0x3282B8), Color(hex: 0xBBE1FA)]),
        Slide(id: 1, title: "Ember", caption: "The last of the fire, glowing", colors: [Color(hex: 0x2D0B00), Color(hex: 0xA4161A), Color(hex: 0xF48C06)]),
        Slide(id: 2, title: "Meadow", caption: "Long grass in the wind", colors: [Color(hex: 0x1B4332), Color(hex: 0x52B788), Color(hex: 0xD8F3DC)]),
        Slide(id: 3, title: "Dusk", caption: "Violet over the hills", colors: [Color(hex: 0x10002B), Color(hex: 0x5A189A), Color(hex: 0xE0AAFF)]),
        Slide(id: 4, title: "Dune", caption: "Sand in the afternoon heat", colors: [Color(hex: 0x6F1D1B), Color(hex: 0xBB9457), Color(hex: 0xFFE6A7)]),
    ]
}

@MainActor @Observable
final class Slideshow {

    let slides = Slide.deck

    /// The card showing.
    private(set) var index = 0

    /// Where the next card's ripple grows from, in the stage's unit space.
    private(set) var origin = UnitPoint.center

    /// How the next card arrives.
    var kind = TransitionKind.ripple

    /// Seconds a card takes to arrive.
    var duration = 1.0

    /// The card being replaced fades out under the new one, rather than
    /// leaving with the same transition run backwards.
    var fadesOut = true

    var slide: Slide { slides[index] }

    /// How the card showing came in, and how it will go.
    var transition: AnyTransition {
        let insertion: AnyTransition
        switch kind {
        case .ripple:   insertion = .ripple(from: origin)
        case .dissolve: insertion = .dissolve
        case .pixelate: insertion = .pixelate
        case .swirl:    insertion = .swirl
        case .glitch:   insertion = .glitch
        }
        return fadesOut ? .asymmetric(insertion: insertion, removal: .opacity) : insertion
    }

    /// The code that makes what the stage shows.
    var code: String {
        let insertion: String
        switch kind {
        case .ripple:
            insertion = ".ripple(from: tap)"
        case .dissolve: insertion = ".dissolve"
        case .pixelate: insertion = ".pixelate"
        case .swirl:    insertion = ".swirl"
        case .glitch:   insertion = ".glitch"
        }
        let transition = fadesOut
            ? ".asymmetric(\n    insertion: \(insertion),\n    removal: .opacity\n  )"
            : insertion
        let tap = kind == .ripple
            ? String(format: "let tap = UnitPoint(\n  x: %.2f, y: %.2f\n)\n\n", origin.x, origin.y)
            : ""
        let code = tap + """
        Card(slide)
          .transition(\(transition))

        withAnimation(
          .easeInOut(duration: \(String(format: "%.1f", duration)))
        ) {
          index += 1
        }
        """
        // Spaces that do not break, so a wrapped line keeps its indent.
        return code.replacingOccurrences(of: " ", with: "\u{00A0}")
    }

    /// Bring on the next card, its ripple growing from `origin`.
    func next(from origin: UnitPoint = .center) {
        show(index + 1, from: origin)
    }

    func previous() {
        show(index - 1, from: .center)
    }

    private func show(_ target: Int, from origin: UnitPoint) {
        self.origin = origin
        withAnimation(.easeInOut(duration: duration)) {
            index = (target % slides.count + slides.count) % slides.count
        }
    }
}
