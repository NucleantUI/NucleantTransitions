//
//  TransitionGalleryApp.swift
//  TransitionGallery
//
//  A slideshow of cards, each arriving with the shader transition picked in
//  the sidebar. Click a card to bring on the next one from where you
//  clicked — the ripple grows from there — or step through with the
//  buttons and the arrow keys.
//

import NucleantTransitions
import NucleantUI

enum Theme {
    static let sidebar = ShapeStyle.dynamic(light: Color(hex: 0xEFEDE8), dark: Color(hex: 0x17181C))
    static let stage = ShapeStyle.dynamic(light: Color(hex: 0xF7F6F2), dark: Color(hex: 0x111215))
    static let accent = Color(hex: 0xE0663D)
}

@View
struct GalleryWindow {
    @State private var slideshow = Slideshow()

    var body: some View {
        HStack(spacing: 0) {
            Sidebar(slideshow: slideshow)
                .frame(width: 320)
                .frame(maxHeight: .infinity)
                .background(Theme.sidebar)
            Divider()
            Stage(slideshow: slideshow)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Theme.stage)
        }
        .font(.system(size: 13))
        .tint(Theme.accent)
    }
}

@main
struct TransitionGalleryApp: NucleantApp {
    var body: some Scene {
        WindowGroup("Transition Gallery") {
            GalleryWindow()
        }
        .defaultSize(width: 1180, height: 760)
    }
}
