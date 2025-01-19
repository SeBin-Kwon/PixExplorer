//
//  Photo.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import Foundation

struct PhotoList: Decodable {
    let total: Int
    let total_pages: Int
    let results: [Photo]
}

struct Photo: Decodable {
    let id: String
    let urls: PhotoUrls
    let created_at: String
    let likes: Int
}

struct PhotoUrls: Decodable {
    let full: String
    let small: String
}
