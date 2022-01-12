// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "OneStore",
  platforms: [.iOS(.v12)],
  products: [
    .library(name: "OneStore", targets: ["OneStore"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "OneStore",
      path: "OneStore",
      exclude: ["Info.plist"]
    ),
  ]
)
