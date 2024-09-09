// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DGImageViewer",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DGImageViewer",
            targets: ["DGImageViewer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dmytro-anokhin/url-image.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DGImageViewer",
            dependencies: [
                .product(name: "URLImage", package: "url-image")
            ]
        ),
        .testTarget(
            name: "DGImageViewerTests",
            dependencies: ["DGImageViewer"]),
    ]
)
