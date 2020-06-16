//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case notFound
    case badUrl
    case badFormat
    case failure(message: String)
    case failed(error: Error)
}
