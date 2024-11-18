// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Kingfisher

public struct DGImageViewer: View {
    let url: String
    var preventDragGestureWhenScale1: Bool = false
    
    @State private var image: Image?
    @State private var height: CGFloat = 100

    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 1

    @State private var offset: CGPoint = .zero
    @State private var lastTranslation: CGSize = .zero

    public init(url: String) {
        self.url = url
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                image?
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(scale)
                    .offset(x: offset.x, y: offset.y)
                    .gesture(makeDragGesture(size: proxy.size))
                    .gesture(makeMagnificationGesture(size: proxy.size))
                    .background(ViewGeometry())
                    .onPreferenceChange(ViewSizeKey.self) {
                        height = $0.height
                    }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                Task {
                    self.image = try await ImageManager.image(from: url)
                }
            }
        }
        .frame(height: height)
    }

    private func makeMagnificationGesture(size: CGSize) -> some Gesture {
        MagnificationGesture()
            .onChanged { value in
                let delta = value / lastScale
                lastScale = value

                // To minimize jittering
                if abs(1 - delta) > 0.01 {
                    scale *= delta
                }
            }
            .onEnded { _ in
                lastScale = 1
                if scale < 1 {
                    withAnimation {
                        scale = 1
                    }
                }
                adjustMaxOffset(size: size)
            }
    }

    private func makeDragGesture(size: CGSize) -> some Gesture {
        DragGesture()
            .onChanged { value in
                if preventDragGestureWhenScale1 {
                    guard scale > 1 else { return }
                }
                let diff = CGPoint(
                    x: value.translation.width - lastTranslation.width,
                    y: value.translation.height - lastTranslation.height
                )
                offset = .init(x: offset.x + diff.x, y: offset.y + diff.y)
                lastTranslation = value.translation
            }
            .onEnded { _ in
                adjustMaxOffset(size: size)
            }
    }

    private func adjustMaxOffset(size: CGSize) {
        let maxOffsetX = (size.width * (scale - 1)) / 2
        let maxOffsetY = (size.height * (scale - 1)) / 2

        var newOffsetX = offset.x
        var newOffsetY = offset.y

        if abs(newOffsetX) > maxOffsetX {
            newOffsetX = maxOffsetX * (abs(newOffsetX) / newOffsetX)
        }
        if abs(newOffsetY) > maxOffsetY {
            newOffsetY = maxOffsetY * (abs(newOffsetY) / newOffsetY)
        }

        let newOffset = CGPoint(x: newOffsetX, y: newOffsetY)
        if newOffset != offset {
            withAnimation {
                offset = newOffset
            }
        }
        self.lastTranslation = .zero
    }
}

public extension DGImageViewer {
    func set(preventDragGestureWhenScale1: Bool) -> Self {
        var copy = self
        copy.preventDragGestureWhenScale1 = preventDragGestureWhenScale1
        return copy
    }
}
