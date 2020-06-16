//
//  CitiesNetwork.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

internal class CitiesNetwork: BaseNetwork {
    internal func search(
        queries: [QueryKVO]
    ) throws -> Data {
        return try request(CitiesRequestBuilder.search(queries: queries))
    }
}
