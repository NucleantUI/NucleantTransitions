//
//  NaviKind.swift
//  NaviTransitionGallery
//
//  Every navigation transition NucleantNaviTransitions has: what the
//  gallery calls it, says of it, and plays.
//

import NucleantNaviTransitions
import NucleantUI

enum NaviKind: String, CaseIterable, Hashable, Identifiable {
    case blinds, blur, crt, checkerboard, chromatic, clockWipe, develop, diamond
    case dissolve, doors, dots, flash, glitch, halftone, ink, iris
    case kaleidoscope, melt, motionBlur, pixelate, ripple, shatter, smoke
    case stripes, swirl, tiles, wave, wipe, zoomBlur

    var id: String { rawValue }

    var title: String {
        switch self {
        case .crt: return "CRT"
        case .clockWipe: return "Clock Wipe"
        case .motionBlur: return "Motion Blur"
        case .zoomBlur: return "Zoom Blur"
        default: return rawValue.prefix(1).uppercased() + rawValue.dropFirst()
        }
    }

    /// The call that plays it, as an app writes it.
    var code: String { ".navigationTransition(.\(rawValue))" }

    @MainActor
    var transition: ShaderNavigationTransition {
        switch self {
        case .blinds: return .blinds
        case .blur: return .blur
        case .crt: return .crt
        case .checkerboard: return .checkerboard
        case .chromatic: return .chromatic
        case .clockWipe: return .clockWipe
        case .develop: return .develop
        case .diamond: return .diamond
        case .dissolve: return .dissolve
        case .doors: return .doors
        case .dots: return .dots
        case .flash: return .flash
        case .glitch: return .glitch
        case .halftone: return .halftone
        case .ink: return .ink
        case .iris: return .iris
        case .kaleidoscope: return .kaleidoscope
        case .melt: return .melt
        case .motionBlur: return .motionBlur
        case .pixelate: return .pixelate
        case .ripple: return .ripple
        case .shatter: return .shatter
        case .smoke: return .smoke
        case .stripes: return .stripes
        case .swirl: return .swirl
        case .tiles: return .tiles
        case .wave: return .wave
        case .wipe: return .wipe
        case .zoomBlur: return .zoomBlur
        }
    }

    /// Its screen's colour, round the wheel in order.
    var color: Color {
        let palette: [UInt32] = [
            0xE0663D, 0xD9534F, 0xC2457A, 0x9B4DCA, 0x6A5ACD, 0x3F6FD8,
            0x2A8FBD, 0x1F9E8F, 0x3A9D5D, 0x7AA33A, 0xC4A12E, 0xD9822B,
        ]
        let index = Self.allCases.firstIndex(of: self) ?? 0
        return Color(hex: palette[index % palette.count])
    }

    /// The one after it, wrapping round: each screen offers it, so a stack
    /// several screens deep can be built and popped.
    var next: NaviKind {
        let all = Self.allCases
        let index = all.firstIndex(of: self) ?? 0
        return all[(index + 1) % all.count]
    }
}
