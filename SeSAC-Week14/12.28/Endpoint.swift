//
//  Endpoint.swift
//  SeSAC-Week14
//
//  Created by AlexHwang on 2021/12/29.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum Endpoint {
    case signup
    case login
    case boards
    case boardDetail(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signup:
            return .makeEndpoint("/auth/local/register")
        case .login:
            return .makeEndpoint("/auth/local")
        case .boards:
            return .makeEndpoint("/boards")
        case .boardDetail(let id):
            return .makeEndpoint("/boards/\(id)")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com"
    
    static func makeEndpoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
    
    static var login: URL {
        return makeEndpoint("/auth/local")
    }
}

extension URLSession {
    
    typealias handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult // 반환값 쓰고싶지 않을떄
    func dataTask(_ endpoint: URLRequest, handler: @escaping handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        
        URLSession.shared.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("error : ", error!)
                    DispatchQueue.main.async {
                        completion(nil, .failed)
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    print("response : ", response)
                } else {
                    completion(nil, .invalidResponse)
                }
                
                print("data : ", String(data: data!, encoding: .utf8))
                
                if let data = data, let decodedData = try? JSONDecoder().decode(T.self, from: data) {
                    DispatchQueue.main.async {
                        completion(decodedData, nil)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            }
        }
    }
}


