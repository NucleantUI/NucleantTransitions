// swift-tools-version: 6.2

import Foundation
import PackageDescription

// Transitions drawn by shaders: each runs a PyShader effect over the view
// arriving or leaving, its progress animated by the change that inserted or
// removed it. The shaders are `Shaders/*.py`, compiled to SPIR-V by PyShader's
// build plugin as the library builds (`pyshader.toml`).
//
// A WebAssembly build (WASM_BUILD=1) cannot build the plugin's compiler: it
// leaves out SpirvTools' macOS library, which the compiler needs on the host.
// There the shaders are compiled beforehand into
// Sources/NucleantTransitions/Compiled — `swift package
// --allow-writing-to-package-directory pyshader-compile`, as
// Scripts/build-docs.sh does — and taken as resources instead.
let isWasm = ProcessInfo.processInfo.environment["WASM_BUILD"] == "1"
let hasCompiled = FileManager.default.fileExists(
    atPath: Context.packageDirectory + "/Sources/NucleantTransitions/Compiled"
)

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
        .package(url: "https://github.com/NucleantUI/NucleantUI.git", .upToNextMinor(from: "0.2.0")),
    ] + (isWasm ? [] : [
        .package(url: "https://github.com/NucleantUI/PyShader.git", .upToNextMinor(from: "0.0.6")),
    ]),
    targets: [
        .target(
            name: "NucleantTransitions",
            dependencies: [
                .product(name: "NucleantUI", package: "NucleantUI")
            ],
            exclude: !isWasm && hasCompiled ? ["Compiled"] : [],
            resources: isWasm ? [.process("Compiled")] : [],
            plugins: isWasm ? [] : [.plugin(name: "PyShaderBuildPlugin", package: "PyShader")]
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
