//
//  NaviTransitionGalleryApp.swift
//  NaviTransitionGallery
//
//  A navigation stack where every screen arrives through the shader
//  transition it is named for, and leaves through it when popped: pick one
//  from the grid, then go on to the next from each screen, or back.
//

import NucleantNaviTransitions
import NucleantUI

@View
struct GalleryRoot {
    var body: some View {
        NavigationStack {
            TransitionGrid()
                .navigationDestination(for: NaviKind.self) { kind in
                    KindScreen(kind: kind)
                        .navigationTransition(kind.transition)
                }
        }
        .colorScheme(.dark)
    }
}

@main
struct NaviTransitionGalleryApp: NucleantApp {
    var body: some Scene {
        WindowGroup("Navigation Transitions") {
            GalleryRoot()
        }
        .defaultSize(width: 1000, height: 720)
    }
}
