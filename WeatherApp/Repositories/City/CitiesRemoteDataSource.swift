//
//  CitiesRemoteDataSource.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class CitiesRemoteDataSource: DataSource<City, Pagination> {
    override public func get(query: [QueryKVO]) throws -> ([City], Pagination) {
        return try CitiesManager.shared.search(query: query)
    }
}
