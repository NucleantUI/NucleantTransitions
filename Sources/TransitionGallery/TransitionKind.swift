//
//  TransitionKind.swift
//  TransitionGallery
//
//  Every transition in the package, as the gallery lists it: its name, its
//  group, what it does, how to make it for a card arriving from a point,
//  and the code that does.
//

import NucleantTransitions
import NucleantUI

/// One of the package's transitions.
struct TransitionKind: Identifiable, Equatable {

    enum Group: String, CaseIterable, Identifiable {
        case reveals = "Reveals"
        case motion = "Motion"
        case dissolves = "Dissolves"
        case effects = "Effects"

        var id: Self { self }
    }

    let name: String
    let group: Group
    let summary: String
    /// Whether it grows from a point — the gallery's click.
    let usesPoint: Bool
    /// The transition, for a card arriving from `point`.
    let make: @MainActor (UnitPoint) -> AnyTransition
    /// The insertion as code, `tap` standing for the point.
    let code: String

    var id: String { name }

    static func == (lhs: TransitionKind, rhs: TransitionKind) -> Bool {
        lhs.name == rhs.name
    }

    static func from(_ group: Group) -> [TransitionKind] {
        all.filter { $0.group == group }
    }

    static let all: [TransitionKind] = [
        // Reveals: the card shown through a shape that grows.
        TransitionKind(name: "Ripple", group: .reveals, summary: "A circle grows from where you clicked until it covers the card, rippling just behind its rim.",
                       usesPoint: true, make: { .ripple(from: $0) }, code: ".ripple(from: tap)"),
        TransitionKind(name: "Iris", group: .reveals, summary: "A clean circle opens from where you clicked.",
                       usesPoint: true, make: { .iris(from: $0) }, code: ".iris(from: tap)"),
        TransitionKind(name: "Diamond", group: .reveals, summary: "A diamond opens from where you clicked.",
                       usesPoint: true, make: { .diamond(from: $0) }, code: ".diamond(from: tap)"),
        TransitionKind(name: "Ink", group: .reveals, summary: "Ink soaks outward from where you clicked, its edge ragged.",
                       usesPoint: true, make: { .ink(from: $0) }, code: ".ink(from: tap)"),
        TransitionKind(name: "Dots", group: .reveals, summary: "A grid of dots swells outward from where you clicked until they merge.",
                       usesPoint: true, make: { .dots(from: $0) }, code: ".dots(from: tap)"),
        TransitionKind(name: "Wipe", group: .reveals, summary: "A soft edge sweeps across from the leading side.",
                       usesPoint: false, make: { _ in .wipe(from: .leading) }, code: ".wipe(from: .leading)"),
        TransitionKind(name: "Clock wipe", group: .reveals, summary: "A hand sweeps round from twelve o'clock.",
                       usesPoint: false, make: { _ in .clockWipe }, code: ".clockWipe"),
        TransitionKind(name: "Blinds", group: .reveals, summary: "Level slats open together, like a blind tilted open.",
                       usesPoint: false, make: { _ in .blinds }, code: ".blinds"),
        TransitionKind(name: "Checkerboard", group: .reveals, summary: "Squares grow out of a checkerboard, one colour of square and then the other.",
                       usesPoint: false, make: { _ in .checkerboard }, code: ".checkerboard"),
        TransitionKind(name: "Tiles", group: .reveals, summary: "Square tiles fade in one by one, in no order.",
                       usesPoint: false, make: { _ in .tiles }, code: ".tiles"),

        // Motion: the card's pixels travel into place.
        TransitionKind(name: "Swirl", group: .motion, summary: "The card unwinds out of its centre.",
                       usesPoint: false, make: { _ in .swirl }, code: ".swirl"),
        TransitionKind(name: "Doors", group: .motion, summary: "Two halves slide in from either side and meet in the middle.",
                       usesPoint: false, make: { _ in .doors }, code: ".doors"),
        TransitionKind(name: "Stripes", group: .motion, summary: "Strips slide in from alternate sides, one after another.",
                       usesPoint: false, make: { _ in .stripes }, code: ".stripes"),
        TransitionKind(name: "Melt", group: .motion, summary: "The card drips down into place, column by column.",
                       usesPoint: false, make: { _ in .melt }, code: ".melt"),
        TransitionKind(name: "Motion blur", group: .motion, summary: "The card slides in from the leading edge, smeared along the way it moves.",
                       usesPoint: false, make: { _ in .motionBlur(from: .leading) }, code: ".motionBlur(from: .leading)"),
        TransitionKind(name: "Zoom blur", group: .motion, summary: "The card rushes in from far off, streaked towards where you clicked.",
                       usesPoint: true, make: { .zoomBlur(from: $0) }, code: ".zoomBlur(from: tap)"),
        TransitionKind(name: "Shatter", group: .motion, summary: "Shards fly in from around the card, turning as they come, and settle each in its own time.",
                       usesPoint: false, make: { _ in .shatter }, code: ".shatter"),
        TransitionKind(name: "Kaleidoscope", group: .motion, summary: "The card is folded into a turning kaleidoscope that opens out into it.",
                       usesPoint: false, make: { _ in .kaleidoscope }, code: ".kaleidoscope"),
        TransitionKind(name: "Wave", group: .motion, summary: "The card rolls in on waves that flatten as it settles.",
                       usesPoint: false, make: { _ in .wave }, code: ".wave"),

        // Dissolves: the card forms in place.
        TransitionKind(name: "Dissolve", group: .dissolves, summary: "The card forms out of noise, the edge of what has formed glowing.",
                       usesPoint: false, make: { _ in .dissolve }, code: ".dissolve"),
        TransitionKind(name: "Smoke", group: .dissolves, summary: "The card gathers out of drifting smoke.",
                       usesPoint: false, make: { _ in .smoke }, code: ".smoke"),
        TransitionKind(name: "Pixelate", group: .dissolves, summary: "Coarse blocks sharpen into the card's pixels.",
                       usesPoint: false, make: { _ in .pixelate }, code: ".pixelate"),
        TransitionKind(name: "Halftone", group: .dissolves, summary: "Halftone dots swell until they merge into the card.",
                       usesPoint: false, make: { _ in .halftone }, code: ".halftone"),
        TransitionKind(name: "Blur", group: .dissolves, summary: "The card comes into focus.",
                       usesPoint: false, make: { _ in .blur }, code: ".blur"),

        // Effects: the card arrives through a look.
        TransitionKind(name: "Glitch", group: .effects, summary: "Torn slices jump sideways, their colour channels pulled apart, and settle.",
                       usesPoint: false, make: { _ in .glitch }, code: ".glitch"),
        TransitionKind(name: "Chromatic", group: .effects, summary: "The colour channels fly apart from the centre and come back together.",
                       usesPoint: false, make: { _ in .chromatic }, code: ".chromatic"),
        TransitionKind(name: "CRT", group: .effects, summary: "An old television switches on: a bright line opens across, then out to the picture, which settles from glare.",
                       usesPoint: false, make: { _ in .crt }, code: ".crt"),
        TransitionKind(name: "Flash", group: .effects, summary: "A white flash fades to show the card.",
                       usesPoint: false, make: { _ in .flash }, code: ".flash"),
        TransitionKind(name: "Develop", group: .effects, summary: "The card develops like a photograph: dark and grey first, its colour and light coming up.",
                       usesPoint: false, make: { _ in .develop }, code: ".develop"),
    ]
}
