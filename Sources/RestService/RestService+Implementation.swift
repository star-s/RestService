//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.04.2021.
//

import Foundation

public extension RestService {

    func makeURL(from path: Path) throws -> URL {
        guard let url = URL(string: String(describing: path)) else {
            throw URLError(.badURL)
        }
        return url
    }
    
    func post<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?) async throws -> T {
        let request = try presenter.prepare(post: makeURL(from: path), parameters: parameters)
        let response = try await transport.perform(request)
        let data = try presenter.validate(data: response.data, response: response.response)
        return try presenter.decode(data: data, decodingPath: decodingPath)
    }
    
    func get<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?) async throws -> T {
        let request = try presenter.prepare(get: makeURL(from: path), parameters: parameters)
        let response = try await transport.perform(request)
        let data = try presenter.validate(data: response.data, response: response.response)
        return try presenter.decode(data: data, decodingPath: decodingPath)
    }
    
    func put<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?) async throws -> T {
        let request = try presenter.prepare(put: makeURL(from: path), parameters: parameters)
        let response = try await transport.perform(request)
        let data = try presenter.validate(data: response.data, response: response.response)
        return try presenter.decode(data: data, decodingPath: decodingPath)
    }
    
    func patch<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?) async throws -> T {
        let request = try presenter.prepare(patch: makeURL(from: path), parameters: parameters)
        let response = try await transport.perform(request)
        let data = try presenter.validate(data: response.data, response: response.response)
        return try presenter.decode(data: data, decodingPath: decodingPath)
    }
    
    func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?) async throws -> T {
        let request = try presenter.prepare(delete: makeURL(from: path), parameters: parameters)
        let response = try await transport.perform(request)
        let data = try presenter.validate(data: response.data, response: response.response)
        return try presenter.decode(data: data, decodingPath: decodingPath)
    }
}

public extension RestService where Self: PresentationLayer {
    var presenter: Self { self }
}

public extension RestService where Self: TransportLayer {
    var transport: Self { self }
}
