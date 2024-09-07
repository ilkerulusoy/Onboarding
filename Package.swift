// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "Onboarding",
    platforms: [
        .iOS(.v16),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],

    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Onboarding",
            targets: ["Onboarding"]),
        
    ],
    dependencies: [
//        .package(url:"https://github.com/ilkerulusoy/Extensions", branch: "main"),
        .package(path: "../Extensions")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Onboarding",
            dependencies: [
                  // Add the Extensions package as a dependency here
                  "Extensions"
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        )
    ]
)
