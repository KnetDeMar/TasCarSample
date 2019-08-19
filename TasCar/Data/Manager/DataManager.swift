//
//  FileManager.swift
//  TasCar
//
//  Created by Enrique Canedo on 08/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift
import CocoaLumberjack

final class DataManager {
    
    static let shared = DataManager()
    
    func loadJson<T: Decodable>(type: T.Type, fileName: String) -> Single<[T]> {
        do {
            return try loadData(fileName: fileName)
                .map { data -> [T] in
                    return try JSONDecoder().decode([T].self, from: data)
            }
        } catch let error {
            return Single.error(error)
        }
    }
    
    func loadData(fileName: String) throws -> Single<Data> {
        return try Single.just(readFile(fileName: fileName))
    }
    
    // MARK: - Private functions
    
    private func logError(_ error: Error) {
        DDLogError(error.localizedDescription)
    }
    
    private func readFile(fileName: String) throws -> Data {
        let data = try Data(contentsOf: try checkFileExists(fileName: fileName))
        if data.isEmpty {
            throw DataManagerError.noData
        }
        return data
    }
    
    private func checkFileExists(fileName: String) throws -> URL {
        guard let path = Bundle.main.path(forResource: fileName, ofType: Files.fileExtension) else {
            throw DataManagerError.invalidFile
        }
        
        return URL(fileURLWithPath: path)
    }
    
}
