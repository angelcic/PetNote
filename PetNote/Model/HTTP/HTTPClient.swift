//
//  HTTPClient.swift
//  PetNote
//
//  Created by iching chen on 2019/9/21.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

//swiftlint:disable force_cast
enum PNHTTPMethod: String {
    
    case GET
    
    case POST
}

class HTTPClient {
    static let shared = HTTPClient()
    
    private let decoder = JSONDecoder()
    
    private let encoder = JSONEncoder()
    
    private init() {}
    
    func httpRequest(request: Request,
                     completion: @escaping (Result<Data>) -> Void) {
        httpRequest(request: request.makeRequest(), completion: completion)
    }
    
    func httpRequest(request: URLRequest,
                     completion: @escaping (Result<Data>) -> Void) {
        
        URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                
                guard error == nil else {
                    
                    return completion(Result.failure(error!))
                }
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                switch statusCode {
                    
                case 200..<300:
                    
                    completion(Result.success(data!))
                    
                case 400..<500:
                    completion(Result.failure(HTTPClientError.clientError(data!)))
                    
                case 500..<600:
                    
                    completion(Result.failure(HTTPClientError.serverError))
                    
                default: return
                    
                    completion(Result.failure(HTTPClientError.unexpectedError))
                }
                
        }).resume()
    }
    
    enum HTTPClientError: Error {
        
        case decodeDataFail
        
        case clientError(Data)
        
        case serverError
        
        case unexpectedError
    }
    
    enum Result<T> {
        
        case success(T)
        
        case failure(Error)
    }
    
}

protocol Request {
    
    var headers: [String: String] { get }
    
    var body: Data? { get }
    
    var method: String { get }
    
    var endPoint: String { get }
}

extension Request {
    
    func makeRequest() -> URLRequest {
        
//        let urlString = Bundle.main.infoDictionary!["PNHospitalBaseURL"] as! String + endPoint
//        print(urlString)
//        let url = URL(string: urlString)!
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "data.coa.gov.tw"
        urlComponent.path = "/Service/OpenData/DataFileService.aspx"
        urlComponent.queryItems = [
            URLQueryItem(name: "UnitId", value: "078"),
            URLQueryItem(name: "$top", value: "1000"),
            URLQueryItem(name: "$skip", value: "0"),
            URLQueryItem(name: "$filter", value: endPoint)
        ]
        
        let url = urlComponent.url!
        print(url.absoluteString)
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        
        request.httpBody = body
        
        request.httpMethod = method
        
        return request
    }
}

//swiftlint:enable force_cast
