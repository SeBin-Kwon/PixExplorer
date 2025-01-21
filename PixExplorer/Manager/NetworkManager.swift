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
    
    func fetchPhotoSearchResults(api: UnsplashRequest, _ completionHandler: @escaping (PhotoList) -> Void) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PhotoList.self) { response in
                switch response.result {
                case .success(let value):
                    print("Success")
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchPhotoDetailResults(api: UnsplashRequest,_  completionHandler: @escaping (PhotoDetail?) -> Void) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PhotoDetail.self) { response in
                switch response.result {
                case .success(let value):
                    print("Success")
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchPhotoTopicResults(api: UnsplashRequest, _ completionHandler: @escaping ([Photo]?) -> Void) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Photo].self) { response in
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
