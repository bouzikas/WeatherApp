//
//  BaseNetwork.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation
import Alamofire

internal class BaseNetwork {
    
    internal let session: Session!
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        session = Session(configuration: configuration)
    }
    
    /// Alamofire request wrapper with Async await approach
    ///
    /// - Parameter urlRequest: Request Builder
    /// - Throws: An error of type `NetworkError`
    internal func request(_ urlRequest: URLRequestConvertible) throws -> Data {
        
        var data: Data?
        var error: NetworkError?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        session.request(urlRequest).responseJSON { response in
            switch response.result {
            case .success:
                if let jsonData = response.data {
                    data = jsonData
                } else {
                    error = NetworkError.badFormat
                }
            case let .failure(err):
                error = NetworkError.failed(error: err)
            }
            
            semaphore.signal()
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        guard data != nil, error == nil else {
            throw error!
        }
        
        return data!
    }
}
