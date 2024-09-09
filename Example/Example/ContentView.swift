//
//  ContentView.swift
//  Example
//
//  Created by 신동규 on 9/9/24.
//

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
