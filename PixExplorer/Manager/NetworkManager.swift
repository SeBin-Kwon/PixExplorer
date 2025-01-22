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
    
    func fetchPhotoResults<T: Decodable>(api: UnsplashRequest, type: T.Type, _ completionHandler: @escaping (T) -> Void, failHandler: @escaping (Error) -> Void) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    print("Success")
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                    failHandler(error)
                }
            }
    }
    
}
