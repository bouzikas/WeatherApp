//
//  CitiesManager.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class CitiesManager {
    private let network = CitiesNetwork()
    private let translation = CitiesTranslation()

    /// Singleton instance
    public static let shared = CitiesManager()
    
    public func search(
        query: [QueryKVO]
    ) throws -> ([City], Pagination) {
        do {
            let data = try network.search(queries: query)
            return try translation.searchResponse(data)
        } catch {
            throw error
        }
    }
}
