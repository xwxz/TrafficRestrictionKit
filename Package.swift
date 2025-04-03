// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "TrafficRestrictionKit",
    products: [
        .library(
            name: "TrafficRestrictionKit",
            targets: ["TrafficRestrictionKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TrafficRestrictionKit",
            dependencies: []),
        .testTarget(
            name: "TrafficRestrictionKitTests",
            dependencies: ["TrafficRestrictionKit"]),
    ]
)
