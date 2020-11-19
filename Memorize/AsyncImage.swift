//
//  AsyncImage.swift
//  Memorize
//
//  Created by Hanna Lisa Franz on 18.11.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct AsyncImage: View {
    @ObservedObject private var loader: ImageLoader
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.image = image
        _loader = ObservedObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
                    .resizable()
                    .scaledToFit()
                
            }else{
                Text("loading")
            }
        }
    }
}
