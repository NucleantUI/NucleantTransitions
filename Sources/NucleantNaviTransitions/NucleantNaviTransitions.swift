//
//  NucleantNaviTransitions.swift
//  NucleantNaviTransitions
//
//  NucleantTransitions' shaders as navigation transitions: the screen a
//  `NavigationStack` pushes arrives through one over the screen below, and
//  leaves through it, backwards, when popped.
//
//  ```swift
//  .navigationDestination(for: Photo.self) { photo in
//      PhotoDetail(photo)
//          .navigationTransition(.dissolve)
//  }
//  ```
//
//  Each is a `ShaderNavigationTransition` over the same compiled shader as
//  the view transition of the same name, with the same arguments, and a
//  `timing` — a smooth 0.6 s unless asked otherwise.
//

import NucleantUI
