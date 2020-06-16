//
//  CacheDataManager.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class CacheDataManager {
    static fileprivate func getDocumentDirectory() -> URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to get document directory")
        }
        
        return url
    }
    
    static func save<T: Encodable>(_ object: T, with fileName: String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        do {
            let data = try JSONEncoder().encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            
            FileManager.default.createFile(
                atPath: url.path,
                contents: data,
                attributes: nil
            )
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static func load<T: Decodable>(_ fileName: String, with type: T.Type) -> T? {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            return nil
//            fatalError("File not found at path \(url.path)")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func loadData(_ fileName: String) -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path \(url.path)")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            return data
        } else {
            fatalError("Data unavailable at path \(url.path)")
        }
    }
    
    static func loadAll<T: Decodable>(_ type: T.Type) throws -> [T] {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            
            var modelObjects = [T]()
            for fileName in files {
                if let data = load(fileName, with: type) {
                    modelObjects.append(data)
                }
            }
            return modelObjects
            
        } catch {
            throw TranslationError.wrongFormat // fatalError("could not load any files")
        }
    }
    
    static func delete(_ fileName: String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
