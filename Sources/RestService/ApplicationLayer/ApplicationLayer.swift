//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation

public protocol ApplicationLayer {
    associatedtype Path
    
    func post<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void)
    func get<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void)
    func put<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void)
    func patch<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void)
    func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void)
}
