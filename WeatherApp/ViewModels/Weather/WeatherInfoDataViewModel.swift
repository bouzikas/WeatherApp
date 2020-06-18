//
//  WeatherInfoDataViewModel.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 18/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public struct WeatherInfoDataViewModel {
    public var current: WeatherNowViewModel
    public var weatherInfos: [WeatherInfoViewModel]
    
    init(weatherInfo: WeatherInfoDataResponse) {
        self.current = WeatherNowViewModel(weather: weatherInfo.currentCondition)
        self.weatherInfos = weatherInfo.weathers.map {
            return WeatherInfoViewModel(weather: $0)
        }
    }
}

public struct WeatherNowViewModel {
    public var time: String
    public var tempC: String
    public let code: String
    public let desc: String
    public let icon: String
    
    init(weather: WeatherNow) {
        self.time = weather.time
        self.tempC = weather.tempC + "°"
        self.code = weather.weatherCode
        self.desc = weather.weatherDesc
        self.icon = WeatherConfig.asset(forCode: Int(self.code) ?? 0)
    }
}
