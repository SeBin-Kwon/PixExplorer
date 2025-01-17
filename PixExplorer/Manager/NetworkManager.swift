//
//  NetworkManager.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shard = NetworkManager()
    private init() {}
    private let header: HTTPHeaders = ["Authorization": APIKey.unsplash]
    func callRequest(_ query: String, _ page: Int, sort: String? = nil, _ completionHandler: @escaping (PhotoList?) -> Void) {
        var url = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&per_page=20&order_by=latest"
        if let sort {
            url += "&sort=\(sort)"
            print(url)
        }
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: PhotoList.self) { response in
                print(response.response?.statusCode)
                guard let statusCode = response.response?.statusCode else { return }
                if statusCode >= 400 && statusCode < 500 {
                    completionHandler(nil)
                    return
                }
                switch response.result {
                case .success(let value):
                    print("Success")
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
