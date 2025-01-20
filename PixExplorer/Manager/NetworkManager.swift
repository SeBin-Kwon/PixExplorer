//
//  NetworkManager.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    private let header: HTTPHeaders = ["Authorization": APIKey.unsplash]
    func fetchPhotoSearchResults(_ query: String, _ page: Int, _ order: Bool, _ color: String? = nil, _ completionHandler: @escaping (PhotoList?) -> Void) {
        var url = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&per_page=20"
        if order {
            url += "&order_by=latest"
        }
        if let color {
            url += "&color=\(color)"
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
    
    func fetchPhotoDetailResults(_ query: String, _ completionHandler: @escaping (PhotoDetail?) -> Void) {
        var url = "https://api.unsplash.com/photos/\(query)/statistics?"
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: PhotoDetail.self) { response in
                print(response.response?.statusCode)
                guard let statusCode = response.response?.statusCode else { return }
                if statusCode >= 400 && statusCode < 500 {
                    completionHandler(nil)
                    return
                }
                switch response.result {
                case .success(let value):
                    print("Success Detail")
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
    func fetchPhotoTopicResults(_ topic: String, _ completionHandler: @escaping ([Photo]?) -> Void) {
        
            let url = "https://api.unsplash.com/topics/\(topic)/photos?page=1"
            AF.request(url, method: .get, headers: header)
                .validate(statusCode: 200..<500)
                .responseDecodable(of: [Photo].self) { response in
                    print(response.response?.statusCode)
                    guard let statusCode = response.response?.statusCode else { return }
                    if statusCode >= 400 && statusCode < 500 {
                        completionHandler(nil)
                        return
                    }
                    switch response.result {
                    case .success(let value):
                        print("Success Detail")
                        completionHandler(value)
                    case .failure(let error):
                        print(error)
                    }
                }
    }
    
}
