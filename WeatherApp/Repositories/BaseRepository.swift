//
//  BaseRepository.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class DataSource<T, K> {
    public func getAll() throws -> [T] { fatalError() }
    public func get(query: [QueryKVO]) throws -> ([T], K) { fatalError() }
    public func find(byId primaryKey: Int, query: [QueryKVO]) throws -> T { fatalError() }
    public func save(entity: T) throws -> Bool { fatalError() }
}

public class BaseRepository<Model, Page>: Repository {
    var remoteDataSource: DataSource<Model, Page>!
    var localDataSource: DataSource<Model, Page>!
  
    public var resultSet = (Observable<[Model]?>(nil), Page?(nil))
    public var result = Observable<Model?>(nil)
    public var resultBool = Observable<Bool?>(nil)
    public var resultError = Observable<Error?>(nil)
    
    // Saves the given entity
    func save(entity: Model) -> Observable<Bool?> {
        func remote(entity: Model) {
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    if try self.remoteDataSource.save(entity: entity) {
                        // success
                        DispatchQueue.main.async {
                            self.result.value = entity
                        }
                    } else {
                        throw NetworkError.failure(message: "Failed to save entity")
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.resultError.value = error
                    }
                }
            }
        }
        
        // cleanup previous responses
        self.resultBool.value = nil
        self.resultError.value = nil
        
        // then the remote
        remote(entity: entity)
        
        return resultBool
    }
                   
    // Returns the entity identified by the given id.
    // find(byId primaryKey)

    // Returns all entities.
    // Iterable<T> findAll()

    // Returns the number of entities.
    // count()
                   
    // Deletes the given entity
    // void delete(entity)
       
    // Indicates whether an entity with the given id exists.
    // Bool exists(id)
    
    func getAll(completion: @escaping (Error?) -> ()) -> Observable<[Model]?> {
        
        func local(completion: @escaping (Error?) -> ()) {
            // for now we arent going to support local repository
            // cause its not implemented yet
            // self.resultSet.value = try localDataSource.getAll()
        }
        
        func remote(completion: @escaping (Error?) -> ()) {
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    let results = try self.remoteDataSource.getAll()
                    DispatchQueue.main.async {
                        self.resultSet.0.value = results
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(error)
                    }
                }
            }
        }

        // cleanup previous resultSet
        self.resultSet.0.value = nil
        
        // first we load the local
        local(completion: completion)
        
        // then the remote
        remote(completion: completion)
        
        return self.resultSet.0
    }
    
    func find(byId primaryKey: Int, completion: @escaping (Error?) -> ()) -> Observable<Model?> {
        
        func local(completion: @escaping (Error?) -> ()) {
            // for now we arent going to support local repository
            // cause its not implemented yet
            // self.resultSet.value = try localDataSource.getAll()
        }
        
        func remote(completion: @escaping (Error?) -> ()) {
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    let result = try self.remoteDataSource.find(byId: primaryKey, query: [])
                    DispatchQueue.main.async {
                        self.result.value = result
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(error)
                    }
                }
            }
        }

        // cleanup previous resultSet
        self.result.value = nil
        
        // first we load the local
        local(completion: completion)
        
        // then the remote
        remote(completion: completion)
        
        return self.result
    }
}
