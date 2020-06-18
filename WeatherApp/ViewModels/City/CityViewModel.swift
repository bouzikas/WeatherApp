//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public struct CityViewModel {
    public var id: Int
    public var name: String
    public var country: String
    public var region: String
    public var city: City
    
    public var weatherInfoViewModel = Observable<WeatherInfoDataViewModel?>(nil)
    public var error = Observable<Error?>(nil)
    
    init(city: City) {
        self.id = city.id
        self.name = city.name
        self.country = city.country
        self.region = city.region
        self.city = city
    }
    
    public func fetchWeatherInfo() -> Observable<WeatherInfoDataViewModel?> {
        // clean previous result
        self.weatherInfoViewModel.value = nil
        
        let query = [
            QueryKVO(
                key: Constants.QueryKeys.query,
                value: self.name
            ),
            QueryKVO(
                key: Constants.QueryKeys.numOfDays,
                value: 5
            ),
            QueryKVO(
                key: Constants.QueryKeys.format,
                value: Constants.QueryKeys.json
            ),
            // we need to set to 1 in order to get hourly intervals
            QueryKVO(
                key: Constants.QueryKeys.tp,
                value: 1
            )
        ]
        
        WeatherQueryDataRepository.shared.find(byId: 0, andTerms: query) { (error) in
            self.error.value = error
        }.bind { weatherInfo in
            guard let weatherInfo = weatherInfo else { return }
            self.weatherInfoViewModel.value = WeatherInfoDataViewModel(weatherInfo: weatherInfo)
        }
        
        return self.weatherInfoViewModel
    }
    
    public func save() {
        CacheDataManager.save(self.city, with: "\(self.id)")
    }
    
    public func delete() {
        CacheDataManager.delete("\(self.id)")
    }
}
