# SwiftLang

Multi-platform localization module on pure Swift.

This small module allows you to embed a centralized localization system into your multi-platform applications. Provides "SLLocalizedObject" to get a set of translated words, as well as "SLLocalizingService" needed to deserialize dictionaries stored in the JSON file and handle requests from "SLLocalizedObject".

## Schema
![SchemaImage](SwiftLangSchema.jpg)

## Requirements
- swift-tools-version:5.3 or higher

## Installation

### Swift Package Manager
Create a new package with 
```bash
$ swift package init
```

or use a ready-made package. Open file `Package.swift` and add dependencies: 

```swift
let package = Package(
  name: "TestProject",
  dependencies: [
    .package(url: "https://github.com/DevilSmith/swiftlang", .branch("main"))
  ],
  targets: [
    .target(name: "TestProject", dependencies: ["SwiftLang"])
  ]
)
```

## Usage
In order to start working with SwiftLang you need to create a JSON file (or several) in a convenient place in the project, in which dictionaries (language sets) will be described. The structure of the JSON file should match the example below:
