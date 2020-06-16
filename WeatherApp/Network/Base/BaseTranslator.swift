//
//  BaseTranslator.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class BaseTranslator {
    public func translate<T>(_ type: T.Type, _ data: Data?) throws -> T where T: Decodable {
        return try JSONDecoder().decode(type, from: data!)
    }
}
