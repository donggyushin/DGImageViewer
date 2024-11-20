# DGImageViewer

A content size fit image viewer with pinch-zooming built using SwiftUI.

![DGImageViewer-ezgif com-video-to-gif-converter (1)](https://github.com/user-attachments/assets/1b19df6b-e817-48a1-8aa9-bedc1cee4ea2)

## Installation

### Swift Package Manager

The [Swift Package Manager](https://www.swift.org/documentation/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding `DGImageViewer` as a dependency is as easy as adding it to the dependencies value of your Package.swift or the Package list in Xcode.

```
dependencies: [
   .package(url: "https://github.com/donggyushin/DGImageViewer", .upToNextMajor(from: "1.0.3"))
]
```

Normally you'll want to depend on the DGImageViewer target:

```
.product(name: "DGImageViewer", package: "DGImageViewer")
```

## Usage
```swift
import SwiftUI
import DGImageViewer

struct ContentView: View {
    
    let url: String
    
    var body: some View {
        DGImageViewer(url: url)
            .clipShape(RoundedRectangle(cornerRadius: 17))
    }
}

#Preview {
    ContentView(url: "https://fastly.picsum.photos/id/75/536/354.jpg?hmac=ID27DCTIXwj8cf3T86tXQxX0KRZd6i-4zKwvd1t6GoA")
        .preferredColorScheme(.dark)
}
```
