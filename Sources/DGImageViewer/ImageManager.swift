//
//  File.swift
//  
//
//  Created by 신동규 on 9/9/24.
//

import Kingfisher
import SwiftUI

final class ImageManager {
    static func image(from url: String) async throws -> Image? {
        return try await withCheckedThrowingContinuation { continuation in
            guard let url = URL(string: url) else { return continuation.resume(returning: nil) }
            
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let result):
                    continuation.resume(returning: Image(uiImage: result.image))
                }
            }
        }
    }
}
