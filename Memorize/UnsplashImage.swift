//
//  UnsplashImage.swift
//  Memorize
//
//  Created by Hanna Lisa Franz on 18.11.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import Foundation

struct UnsplashImageURLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    
    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }

}

struct UnsplashImage: Codable, Identifiable, Equatable {
    let id: String
    let urls: UnsplashImageURLs
    enum CodingKeys: String, CodingKey {
        case id
        case urls
    }
    static func == (lhs: UnsplashImage, rhs: UnsplashImage) -> Bool {
            return
                lhs.id == rhs.id
        }

}
