//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.04.2021.
//

import Foundation

// MARK: - Call methods without parameters (Some sugar)

public extension ApplicationLayer {
    
    // MARK: - Without parameters
    
    func post<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void) {
        post(path, parameters: VoidParams(), decodingPath: decodingPath, completion: completion)
    }
    
    func get<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void) {
        get(path, parameters: VoidParams(), decodingPath: decodingPath, completion: completion)
    }
    
    func put<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void) {
        put(path, parameters: VoidParams(), decodingPath: decodingPath, completion: completion)
    }
    
    func patch<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void) {
        patch(path, parameters: VoidParams(), decodingPath: decodingPath, completion: completion)
    }
    
    func delete<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void) {
        delete(path, parameters: VoidParams(), decodingPath: decodingPath, completion: completion)
    }
    
    // MARK: - Without parameters and decoding path
    
    func post<T: Decodable>(_ path: Path, completion: @escaping (Result<T, Error>) -> Void) {
        post(path, parameters: VoidParams(), decodingPath: nil, completion: completion)
    }
    
    func get<T: Decodable>(_ path: Path, completion: @escaping (Result<T, Error>) -> Void) {
        get(path, parameters: VoidParams(), decodingPath: nil, completion: completion)
    }
    
    func put<T: Decodable>(_ path: Path, completion: @escaping (Result<T, Error>) -> Void) {
        put(path, parameters: VoidParams(), decodingPath: nil, completion: completion)
    }
    
    func patch<T: Decodable>(_ path: Path, completion: @escaping (Result<T, Error>) -> Void) {
        patch(path, parameters: VoidParams(), decodingPath: nil, completion: completion)
    }
    
    func delete<T: Decodable>(_ path: Path, completion: @escaping (Result<T, Error>) -> Void) {
        delete(path, parameters: VoidParams(), decodingPath: nil, completion: completion)
    }

    // MARK: - Without decoding path
    
    func post<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
        post(path, parameters: parameters, decodingPath: nil, completion: completion)
    }
    
    func get<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
        get(path, parameters: parameters, decodingPath: nil, completion: completion)
    }
    
    func put<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
        put(path, parameters: parameters, decodingPath: nil, completion: completion)
    }
    
    func patch<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
        patch(path, parameters: parameters, decodingPath: nil, completion: completion)
    }
    
    func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
        delete(path, parameters: parameters, decodingPath: nil, completion: completion)
    }

}

private struct VoidParams: Encodable {}
