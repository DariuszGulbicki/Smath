// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Smath",
    products: [
        .library(
            name: "Smath",
            targets: ["Smath"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Smath",
            dependencies: []),
        .testTarget(
            name: "SmathTests",
            dependencies: ["Smath"]),
    ]
)
