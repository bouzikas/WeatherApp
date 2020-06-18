//
//  WeatherTranslation.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 17/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

internal class WeatherTranslation {
    /// Transforms the data into an array of WeatherInfo
    ///
    /// - Parameter data: <#data description#>
    /// - Returns: array of WeatherInfo objects
    internal func searchResponse(_ data: Data) throws -> WeatherInfoDataResponse {
        do {
            let response = try JSONDecoder().decode(WeatherInfoResponse.self, from: data)
            return response.data
        } catch let translationError {
            print("ERROR - \(#function): \(translationError)")
            throw translationError
        }
    }
}
