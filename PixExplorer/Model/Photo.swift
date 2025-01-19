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
    let user: UserInfo
    let width: Int
    let height: Int
}

struct PhotoUrls: Decodable {
    let full: String
    let small: String
}

struct UserInfo: Decodable {
    let name: String
    let profile_image: ProfileUrls
}

struct ProfileUrls: Decodable {
    let small: String
}
