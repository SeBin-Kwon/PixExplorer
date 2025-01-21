//
//  SearchRequest.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/21/25.
//

import Foundation

struct SearchRequest {
    let query: String
    let page: Int
    let order: Bool
    let color: String?
}

struct TopicRequest {
    let topic: String
    let page: Int
}
