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
            static let weatherUrl = "https://wft-geo-db.p.rapidapi.com/v1/geo"
            static let weatherKey = "61788e4793mshd778c6352953b51p16e886jsne953b8e9fec0"
        #else
            static let weatherUrl = "https://wft-geo-db.p.rapidapi.com/v1/geo"
            static let weatherKey = "61788e4793mshd778c6352953b51p16e886jsne953b8e9fec0"
        #endif
    }
    
    public struct Keys {
        static let xMashape = "X-Mashape-Key"
        static let authorization = "Authorization"
    }
    
    public struct Colors {
        static let globalTint = UIColor.red
        static let lightGray = UIColor(named: "LightGray")
    }
    
    public struct ImageNames {
        static let defaultLogo = "default-logo"
        static let defaultLogoBig = "logo-launch"
    }
    
    public struct QueryKeys {
        static let query = "query"
        static let type = "type"
        static let namePrefix = "namePrefix"
        static let sort = "sort"
        static let start = "start"
        static let desc = "desc"
        static let limit = "limit"
        static let page = "page"
    }
    
    public struct Fonts {
        static let basic = ""
        static let basicBold = ""
    }
}
