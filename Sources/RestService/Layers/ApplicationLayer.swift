//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation
import Combine

public protocol ApplicationLayer {
    
    func post  <P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?) -> AnyPublisher<T, Error>
    func get   <P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?) -> AnyPublisher<T, Error>
    func put   <P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?) -> AnyPublisher<T, Error>
    func patch <P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?) -> AnyPublisher<T, Error>
    func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?) -> AnyPublisher<T, Error>
}

// MARK: - Call methods without parameters

public extension ApplicationLayer {
    
    func post<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        post(path, parameters: VoidParams(), decodingPath: decodingPath)
    }
    
    func get<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        get(path, parameters: VoidParams(), decodingPath: decodingPath)
    }
    
    func put<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        put(path, parameters: VoidParams(), decodingPath: decodingPath)
    }
    
    func patch<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        patch(path, parameters: VoidParams(), decodingPath: decodingPath)
    }
    
    func delete<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        delete(path, parameters: VoidParams(), decodingPath: decodingPath)
    }
}

struct VoidParams: Encodable {}
