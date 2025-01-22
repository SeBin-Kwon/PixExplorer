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
    
    func fetchPhotoResults<T: Decodable>(api: UnsplashRequest, type: T.Type, _ completionHandler: @escaping (T) -> Void, failHandler: @escaping (Int, ErrorType) -> Void) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    print("Success")
                    completionHandler(value)
                case .failure(let error):
                    guard let code = error.responseCode else { return }
                    switch code {
                    case 400:
                        failHandler(code, ErrorType.badRequest)
                    case 401:
                        failHandler(code, ErrorType.unauthorized)
                    case 403:
                        failHandler(code, ErrorType.forbidden)
                    case 404:
                        failHandler(code, ErrorType.notFound)
                    case 500, 503:
                        failHandler(code, ErrorType.server)
                    default:
                        failHandler(code, ErrorType.server)
                    }
                }
            }
    }
 
    enum ErrorType: String {
        case badRequest = "잘못된 요청"
        case unauthorized = "승인되지 않음"
        case forbidden = "금지됨"
        case notFound = "찾을 수 없음"
        case server = "서버 오류"
        
        var reason: String {
            switch self {
            case .badRequest: return "필수 매개변수가 누락되었습니다."
            case .unauthorized: return "잘못된 엑세스 토큰입니다."
            case .forbidden: return "요청을 수행할 권한이 없습니다."
            case .notFound: return "요청하신 리소스가 존재하지 않습니다."
            case .server: return "Unsplash팀에 문의해주세요."
            }
        }
    }
    
}
