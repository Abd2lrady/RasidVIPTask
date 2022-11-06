//
//  NetworkClient.swift
//  iOS_VIPTask
//
//  Created by Fintech on 17/10/2022.
//

import Foundation
import Alamofire

enum APIError: Error {
    case noStatusCode
}

class APIClient {
    
    static let shared = APIClient()
    
    private init() {}
    
    func request(for endpoint: APIRouter,
                 completionHandler: @escaping (Result<Data, Error>) -> Void ) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme.rawValue
        urlComponents.host = endpoint.baseURL
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url
        else { fatalError("can`t get url \(urlComponents.string ?? " not founded ")") }

        let method = Alamofire.HTTPMethod(rawValue: endpoint.method.rawValue)
        let headers = Alamofire.HTTPHeaders(endpoint.headers ?? [:])
        let parameters = endpoint.parameters

        var encoding: ParameterEncoding {
            switch endpoint {
            case .getBranchs, .getBranchDetails:
                return URLEncoding.default
            }
        }

        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers,
                   interceptor: nil,
                   requestModifier: nil).response { response in

            guard let statusCode = response.response?.statusCode
            else {
                completionHandler(.failure(APIError.noStatusCode))
                return
            }

            if  (200 ..< 300) ~= statusCode,
                let data = response.data {
                completionHandler(.success(data))
            }

        }
    }
    
    func request(for endpoint: APIRouter) async throws -> Data {
        let urlString = endpoint.baseURL + "/" + endpoint.path
        
        guard let url = URL(string: urlString)
        else { fatalError("can`t get url \(urlString)") }
        
        let method = Alamofire.HTTPMethod(rawValue: endpoint.method.rawValue)
        let headers = Alamofire.HTTPHeaders(endpoint.headers ?? [:])
        let parameters = endpoint.parameters
        
        var encoding: ParameterEncoding {
            switch endpoint {
            case .getBranchs, .getBranchDetails:
                return URLEncoding.default
            }
        }
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url,
                       method: method,
                       parameters: parameters,
                       encoding: encoding,
                       headers: headers,
                       interceptor: nil,
                       requestModifier: nil).response { response in
                
                guard let statusCode = response.response?.statusCode
                else {
                    continuation.resume(throwing: APIError.noStatusCode)
                    return
                }
                if  (200 ..< 300) ~= statusCode,
                    let data = response.data {
                    continuation.resume(returning: data)
                }
            }
        }
    }
}
