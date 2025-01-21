//
//  UnsplashRequest.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/21/25.
//

import Foundation
import Alamofire

enum UnsplashRequest {
    case search(value: SearchRequest)
    case detail(id: String)
    case topic(value: TopicRequest)
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.unsplash]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var endPoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .detail(let id):
            return URL(string: baseURL + "photos/\(id)/statistics")!
        case .topic(let value):
            return URL(string: baseURL + "topics/\(value.topic)/photos")!
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .search(let value):
            let orderBy = value.order ? "latest" : "relevant"
            var parameters = ["query": value.query, "page": String(value.page), "order_by": orderBy]
            if let color = value.color {
                parameters["color"] = color
            }
            return parameters
        case .detail:
            return nil
        case .topic(let value):
            return ["page": String(value.page)]
        }
    }
}
