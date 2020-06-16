//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public struct CityViewModel: Codable {
    public var id: Int
    public var name: String
    public var country: String
    public var region: String
    
    init(city: City) {
        self.id = city.id
        self.name = city.name
        self.country = city.country
        self.region = city.region
    }
}
