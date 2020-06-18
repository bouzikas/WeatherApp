//
//  Constants.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import UIKit

struct Constants {
    public struct UserDefaults {}
    
    public struct Api {
        #if DEBUG
            static let cityUrl = "https://wft-geo-db.p.rapidapi.com/v1/geo"
            static let cityKey = "61788e4793mshd778c6352953b51p16e886jsne953b8e9fec0"
            static let weatherUrl = "http://api.worldweatheronline.com/premium/v1"
            static let weatherKey = "ead2f4e03e90485a82a74324201706"
        #else
            static let cityUrl = "https://wft-geo-db.p.rapidapi.com/v1/geo"
            static let cityKey = "61788e4793mshd778c6352953b51p16e886jsne953b8e9fec0"
            static let weatherUrl = "http://api.worldweatheronline.com/premium/v1"
            static let weatherKey = "ead2f4e03e90485a82a74324201706"
        #endif
    }
    
    public struct Keys {
        static let xMashape = "X-Mashape-Key"
        static let authorization = "Authorization"
    }
    
    public struct Colors {
        static let globalTint = UIColor(named: "Yellow")
    }
    
    public struct ImageNames {
        static let defaultLogo = "default-logo"
        static let defaultLogoBig = "logo-launch"
    }
    
    public struct QueryKeys {
        static let query = "q"
        static let type = "type"
        static let namePrefix = "namePrefix"
        static let sort = "sort"
        static let start = "start"
        static let desc = "desc"
        static let limit = "limit"
        static let page = "page"
        static let numOfDays = "num_of_days"
        static let format = "format"
        static let json = "json"
        // Switch between weather forecast time interval from 1 hourly, 3 hourly, 6 hourly,
        // 12 hourly (day/night) or 24 hourly (day average). E.g:- tp=24 or tp=12 or tp=6 or tp=3 or tp=1
        static let tp = "tp"
    }
    
    public struct Fonts {
        static let basic = ""
        static let basicBold = ""
    }
}
