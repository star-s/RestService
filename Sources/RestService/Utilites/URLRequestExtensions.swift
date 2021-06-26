//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation

public extension URLRequest {
    
    func settingMethod(_ method: HTTPMethod) -> URLRequest {
        var request = self
        request.httpMethod = method.rawValue
        return request
    }
    
    func settingHeaders(_ headers: HTTPHeaders = .default) -> URLRequest {
        var request = self
        request.headers = headers
        return request
    }
    
    func appendingHeader(_ header: HTTPHeader) -> URLRequest {
        var request = self
        request.headers.add(header)
        return request
    }
    
    func encodingBody<P: Encodable, C: TopLevelEncoderProtocol>(_ parameters: P, coder: C, contentType: String? = nil) throws -> URLRequest where C.Output == Data {
        var request = self
        request.httpBody = try coder.encode(parameters)
        if let type = contentType {
            request.setValue(type, forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    func encodingQuery<P: Encodable, C: TopLevelEncoderProtocol>(_ parameters: P, coder: C) throws -> URLRequest where C.Output == String {
        let query = try coder.encode(parameters)
        if query.isEmpty {
            return self
        }
        guard let preparedURL = url?.appendingQuery(query) else {
            throw URLError(.badURL)
        }
        var request = self
        request.url = preparedURL
        return request
    }

    func encodingQuery<P: Encodable, C: TopLevelEncoderProtocol>(_ parameters: P, coder: C) throws -> URLRequest where C.Output == Data {
        let queryData = try coder.encode(parameters)
        if queryData.isEmpty {
            return self
        }
        let query = String(decoding: queryData, as: Unicode.ASCII.self)
        guard let preparedURL = url?.appendingQuery(query) else {
            throw URLError(.badURL)
        }
        var request = self
        request.url = preparedURL
        return request
    }
}
