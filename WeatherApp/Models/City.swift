//
//  City.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class CitiesDataResponse: Decodable {
    public var results: [City]
    public let pagination: Pagination
    
    private enum CodingKeys: String, CodingKey {
        case data
        case metadata
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let metadata = try container.decode(Metadata.self, forKey: .metadata)
        
        results = try container.decode([City].self, forKey: .data)
        pagination = Pagination(total: metadata.totalCount)
    }
}

public class Metadata: Decodable {
    public let currentOffset: Int
    public let totalCount: Int
}

public class City: Decodable, Encodable {
    public let id: Int
    public let wikiDataId: String?
    public let type: String
    public let city: String
    public let name: String
    public let country: String
    public let countryCode: String
    public let region: String
    public let regionCode: String
    public let latitude: Double
    public let longitude: Double
}
