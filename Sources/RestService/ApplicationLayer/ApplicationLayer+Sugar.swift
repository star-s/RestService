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
    
    func post<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]?) async throws -> T {
        try await post(path, parameters: VoidParams(), decodingPath: decodingPath)
    }
    
    func get<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]?) async throws -> T {
        try await get(path, parameters: VoidParams(), decodingPath: decodingPath)
    }
    
    func put<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]?) async throws -> T {
        try await put(path, parameters: VoidParams(), decodingPath: decodingPath)
    }
    
    func patch<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]?) async throws -> T {
        try await patch(path, parameters: VoidParams(), decodingPath: decodingPath)
    }
    
    func delete<T: Decodable>(_ path: Path, decodingPath: [DecodingKey]?) async throws -> T {
        try await delete(path, parameters: VoidParams(), decodingPath: decodingPath)
    }
    
    // MARK: - Without parameters and decoding path
    
    func post<T: Decodable>(_ path: Path) async throws -> T {
        try await post(path, parameters: VoidParams(), decodingPath: nil)
    }
    
    func get<T: Decodable>(_ path: Path) async throws -> T {
        try await get(path, parameters: VoidParams(), decodingPath: nil)
    }
    
    func put<T: Decodable>(_ path: Path) async throws -> T {
        try await put(path, parameters: VoidParams(), decodingPath: nil)
    }
    
    func patch<T: Decodable>(_ path: Path) async throws -> T {
        try await patch(path, parameters: VoidParams(), decodingPath: nil)
    }
    
    func delete<T: Decodable>(_ path: Path) async throws -> T {
        try await delete(path, parameters: VoidParams(), decodingPath: nil)
    }

    // MARK: - Without decoding path
    
    func post<P: Encodable, T: Decodable>(_ path: Path, parameters: P) async throws -> T {
        try await post(path, parameters: parameters, decodingPath: nil)
    }
    
    func get<P: Encodable, T: Decodable>(_ path: Path, parameters: P) async throws -> T {
        try await get(path, parameters: parameters, decodingPath: nil)
    }
    
    func put<P: Encodable, T: Decodable>(_ path: Path, parameters: P) async throws -> T {
        try await put(path, parameters: parameters, decodingPath: nil)
    }
    
    func patch<P: Encodable, T: Decodable>(_ path: Path, parameters: P) async throws -> T {
        try await patch(path, parameters: parameters, decodingPath: nil)
    }
    
    func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P) async throws -> T {
        try await delete(path, parameters: parameters, decodingPath: nil)
    }

}

private struct VoidParams: Encodable {}
