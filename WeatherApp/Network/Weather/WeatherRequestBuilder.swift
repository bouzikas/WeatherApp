//
//  CitiesRequestBuilder.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 17/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Alamofire
import Foundation

enum WeatherRequestBuilder: URLRequestConvertible {
    case search(queries: [QueryKVO])
    
    private var httpMethod: HTTPMethod {
        return .get
    }

    private var baseUrl: URL {
        switch self {
        case .search:
            return try! Constants.Api.weatherUrl.asURL()
        }
    }
    
    private var path: String {
        switch self {
        case .search:
            return "/weather.ashx"
        }
    }

    private var parameters: [String: Any] {
        switch self {
        case .search(let queries):
            var params = QueryKVO.convert(queriesKVO: queries)
            let apiKey: [String: Any] = ["key": Constants.Api.weatherKey]
            
            params.add(apiKey)
            return params
        }
    }
    
    internal func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: baseUrl.appendingPathComponent(path))

        request = try URLEncoding.default.encode(request, with: parameters)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
}
