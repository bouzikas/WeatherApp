//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 17/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class WeatherManager {
    private let network = WeatherNetwork()
    private let translation = WeatherTranslation()

    /// Singleton instance
    public static let shared = WeatherManager()
    
    public func search(query: [QueryKVO]) throws -> WeatherInfoDataResponse {
        do {
            let data = try network.search(queries: query)
            return try translation.searchResponse(data)
        } catch {
            throw error
        }
    }
}
