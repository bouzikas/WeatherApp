//
//  WeatherNetwork.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 17/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

internal class WeatherNetwork: BaseNetwork {
    internal func search(
        queries: [QueryKVO]
    ) throws -> Data {
        return try request(WeatherRequestBuilder.search(queries: queries))
    }
}
