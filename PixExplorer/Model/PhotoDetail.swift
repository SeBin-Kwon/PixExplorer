//
//  PhotoDetail.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import Foundation

struct PhotoDetail: Decodable {
    let id: String
    let downloads: DownloadsData
    let views: ViewsData
}

struct ViewsData: Decodable {
    let total: Int
}

struct DownloadsData: Decodable {
    let total: Int
}
