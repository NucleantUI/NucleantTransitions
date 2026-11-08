// swift-tools-version: 6.2

import PackageDescription

// Transitions drawn by shaders: each runs a PyShader effect over the view
// arriving or leaving, its progress animated by the change that inserted or
// removed it. The shaders are `Shaders/*.py`, compiled to SPIR-V by PyShader's
// build plugin as the library builds (`pyshader.toml`).
let package = Package(
    name: "NucleantTransitions",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "NucleantTransitions",
            targets: ["NucleantTransitions"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/NucleantUI/NucleantUI.git", branch: "master"),
        .package(url: "https://github.com/NucleantUI/PyShader.git", .upToNextMinor(from: "0.0.6")),
    ],
    targets: [
        .target(
            name: "NucleantTransitions",
            dependencies: [
                .product(name: "NucleantUI", package: "NucleantUI")
            ],
            plugins: [.plugin(name: "PyShaderBuildPlugin", package: "PyShader")]
        ),
        // The showcase app: a deck of cards, each arriving with the
        // transition picked in the sidebar. `swift run TransitionGallery`.
        .executableTarget(
            name: "TransitionGallery",
            dependencies: [
                "NucleantTransitions",
                .product(name: "NucleantUI", package: "NucleantUI")
            ]
        ),
        .testTarget(
            name: "NucleantTransitionsTests",
            dependencies: [
                "NucleantTransitions",
                .product(name: "NucleantUI", package: "NucleantUI")
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
