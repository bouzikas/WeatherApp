//
//  Repository.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype Model
    
    func getAll(completion: @escaping (Error?) -> ()) -> Observable<[Model]?>
    func save(entity: Model) -> Observable<Bool?>
}
