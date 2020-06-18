//
//  WeatherInfoViewModel.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 17/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public struct WeatherInfoViewModel: Codable {
    public var date: String
    public var maxtempC: String
    public var mintempC: String
    public var hourly: [WeatherInfoHourlyViewModel]
    
    init(weather: WeatherInfo) {
        self.date = weather.date
        self.maxtempC = weather.maxtempC
        self.mintempC = weather.mintempC
        self.hourly = weather.hourly.map {
            return WeatherInfoHourlyViewModel(hourly: $0)
        }
    }
}

public struct WeatherInfoHourlyViewModel: Codable {
    public let time: String
    public let tempC: String
    public let code: String
    public let desc: String
    public let humidity: String
    public let icon: String
    
    init(hourly: WeatherHourlyInfo) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = (hourly.time.count <= 3) ? "hmm" : "HHmm"

        var newTime = "00"
        if let date = dateFormatter.date(from: hourly.time) {
            dateFormatter.dateFormat = "HH"
            newTime = dateFormatter.string(from: date)
        }
        
        self.time = newTime
        self.tempC = hourly.tempC + "°"
        self.code = hourly.weatherCode
        self.desc = hourly.weatherDesc[0]["value"] ?? ""
        self.humidity = hourly.humidity
        self.icon = WeatherConfig.asset(forCode: Int(self.code) ?? 0)
    }
}
