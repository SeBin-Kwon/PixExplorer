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
    func fetchPhotoSearchResults(_ query: String, _ page: Int, _ order: Bool, _ completionHandler: @escaping (PhotoList?) -> Void) {
        var url = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&per_page=20"
        if order {
            url += "&order_by=latest"
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
