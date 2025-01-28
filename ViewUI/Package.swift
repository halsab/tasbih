// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewUI",
    platforms: [.iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ViewUI",
            targets: ["ViewUI"]),
    ],
    dependencies: [
        .package(path: "../Helper"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ViewUI",
            dependencies: ["Helper"]
        ),
        .testTarget(
            name: "ViewUITests",
            dependencies: ["ViewUI"]
        ),
    ]
)
