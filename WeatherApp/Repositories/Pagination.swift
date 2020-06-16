//
//  Pagination.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class Pagination: Decodable {
    public let total: Int?
    public let page: Int = 1
    public let limit: Int = 10
    public let totalPages: Int = 1
    
    init(total: Int) {
        self.total = total
    }
}

public class Page<T> {
    public let elements = [T]()
}

struct Pageable<T> {
    let info: Pagination
    let results: Page<T>
}
