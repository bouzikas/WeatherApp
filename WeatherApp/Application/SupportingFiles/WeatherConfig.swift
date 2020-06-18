//
//  WeatherConfig.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 17/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

struct WeatherConfig {
    // Codes could be found here:
    // http://www.worldweatheronline.com/feed/wwoConditionCodes.txt
    public static func asset(forCode code: Int) -> String {
        switch code {
        case 113:
            return "clear-sky"
        case 116:
            return "partly-cloudy"
        case 119:
            return "cloudy"
        case 122, 248, 260:
            return "overcast"
        case 143:
            return "mist"
        case 176, 266, 281, 293, 296, 299, 302, 311, 353, 386:
            return "rain"
        case 305, 308, 314, 356, 359:
            return "heavy-rain"
        case 179, 182, 185, 227, 230, 284, 317, 320, 323, 326, 329, 332, 335, 338, 350, 362, 365, 368, 371, 374, 377, 392, 395:
            return "snow"
        case 200, 389:
            return "thunderstorm"
        default:
            return "clear-sky"
        }
    }
}
