//
//  APIService.swift
//  SeSAC_AuthPractice
//
//  Created by hoseung Lee on 2021/12/27.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class APIService {
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.login.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = ("identifier=\(identifier)&password=\(password)").data(using: .utf8, allowLossyConversion: false)
        
        print("request : ", request)
        
        DispatchQueue.main.async {
            URLSession.request(endpoint: request, completion: completion)
        }
    }
    
    static func lotto(number: Int, completion: @escaping (Lotto?, APIError?) -> Void) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)")!
        
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    print("error : ", error!)
                    DispatchQueue.main.async {
                        completion(nil, .failed)
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                    print("response : ", response)
                } else {
                    completion(nil, .invalidResponse)
                }
                
                if let data = data, let lotto = try? JSONDecoder().decode(Lotto.self, from: data) {
                    DispatchQueue.main.async {
                        completion(lotto, nil)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            }.resume()
        }
    }
    
    static func person(text: String, page: Int, completion: @escaping (Person?, APIError?) -> Void) {
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let key = Constants.TMDB_API.TMDB_KEY
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "language", value: "ko-KR"),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "region", value: "ko-KR"),
        ]
        
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: component.url!) { data, response, error in
                guard error == nil else {
                    print("error : ", error!)
                    DispatchQueue.main.async {
                        completion(nil, .failed)
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                    print("response : ", response)
                } else {
                    completion(nil, .invalidResponse)
                }
                
                if let data = data, let person = try? JSONDecoder().decode(Person.self, from: data) {
                    DispatchQueue.main.async {
                        completion(person, nil)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            }.resume()
        }
    }
}
