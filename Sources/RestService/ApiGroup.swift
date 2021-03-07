//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 17.02.2021.
//

import Foundation
import Combine

public protocol ApiGroup: ApplicationLayer {
    var parent: ApplicationLayer { get }
    var prefix: Path { get }
}

public extension ApiGroup {
    
    func post<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        parent.post(prefix + path, parameters: parameters, decodingPath: decodingPath)
    }
    
    func get<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        parent.get(prefix + path, parameters: parameters, decodingPath: decodingPath)
    }
    
    func put<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        parent.put(prefix + path, parameters: parameters, decodingPath: decodingPath)
    }
    
    func patch<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        parent.patch(prefix + path, parameters: parameters, decodingPath: decodingPath)
    }
    
    func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        parent.delete(prefix + path, parameters: parameters, decodingPath: decodingPath)
    }
}
