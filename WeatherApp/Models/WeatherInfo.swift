//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 17/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class WeatherInfoResponse: Decodable {
    public var data: WeatherInfoDataResponse
}

public class WeatherInfoDataResponse: Decodable {
    public var weathers: [WeatherInfo]
    public var currentCondition: WeatherNow
    // here there are more info like request, ClimateAverages etc.
    // we are omitting all these and keep only weather info we need
    
    private enum CodingKeys: String, CodingKey {
        case weather
        case current_condition
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let currentConditions = try container.decode([WeatherNow].self, forKey: .current_condition)
        
        // we forced to take the first element of this array
        currentCondition = currentConditions[0]
        weathers = try container.decode([WeatherInfo].self, forKey: .weather)
    }
}

public class WeatherInfo: Decodable {
    public let date: String
    public let maxtempC: String
    public let mintempC: String
    public let hourly: [WeatherHourlyInfo]
}

public class WeatherNow: Decodable {
    public var time: String
    public var tempC: String
    public let weatherCode: String
    public let weatherDesc: String
    
    private enum CodingKeys: String, CodingKey {
        case observation_time
        case temp_C
        case weatherCode
        case weatherDesc
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        time = try container.decode(String.self, forKey: .observation_time)
        tempC = try container.decode(String.self, forKey: .temp_C)
        weatherCode = try container.decode(String.self, forKey: .weatherCode)
        
        let weatherDescriptions = try container.decode([[String: String]].self, forKey: .weatherDesc)
        let weatherDescription = weatherDescriptions[0]
        
        weatherDesc = weatherDescription["value"] ?? ""
    }
}

public class WeatherHourlyInfo: Decodable {
    // from doc: Time in hmm format. For example: 100 or 1500.
    public let time: String
    public let tempC: String
    public let weatherCode: String
    public let weatherDesc: [[String: String]]
    public let humidity: String
}
