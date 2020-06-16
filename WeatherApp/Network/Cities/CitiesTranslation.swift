//
//  CitiesTranslation.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

internal class CitiesTranslation {
    /// Transforms the data into a douple of City objects and Pagination
    ///
    /// - Parameter data: <#data description#>
    /// - Returns: array of City objects and Pagination
    internal func searchResponse(_ data: Data) throws -> ([City], Pagination) {
        do {
            let response = try JSONDecoder().decode(CitiesDataResponse.self, from: data)
            return (response.results, response.pagination)
        } catch let translationError {
            print("ERROR - \(#function): \(translationError)")
            throw translationError
        }
    }
}
