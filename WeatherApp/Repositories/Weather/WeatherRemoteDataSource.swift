//
//  WeatherRemoteDataSource.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 17/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class WeatherRemoteDataSource: DataSource<WeatherInfoDataResponse, Pagination> {
    public override func find(byId primaryKey: Int, query: [QueryKVO]) throws -> WeatherInfoDataResponse {
        return try WeatherManager.shared.search(query: query)
    }
}
