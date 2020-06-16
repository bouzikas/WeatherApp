//
//  QueryKVO.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public struct QueryKVO {
    let key: String?
    let value: Any?

    public static func convert(queriesKVO: [QueryKVO]) -> [String: Any] {
        var queries = [String: Any]()

        for queryKVO in queriesKVO {
            if let key = queryKVO.key, queries[key] == nil {
                queries[key] = queryKVO.value
            }
        }

        return queries
    }
}
