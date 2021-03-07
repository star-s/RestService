//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation
import Combine

extension URLRequest {
    
    public init<P: Encodable, C: TopLevelEncoder>(_ method: String, url: URL, parameters: P, bodyCoder: C, contentType: String? = nil) throws where C.Output == Data {
        self.init(url: url)
        httpMethod = method
        try encodeBody(parameters: parameters, coder: bodyCoder, contentType: contentType)
    }
    
    public init<P: Encodable, C: TopLevelEncoder>(_ method: String? = nil, url: URL, parameters: P, queryCoder: C) throws where C.Output == String {
        self.init(url: url)
        if let method = method {
            httpMethod = method
        }
        try encodeQuery(parameters: parameters, coder: queryCoder)
    }
}

extension URLRequest {
    
    public mutating func encodeBody<P: Encodable, C: TopLevelEncoder>(parameters: P, coder: C, contentType: String? = nil) throws where C.Output == Data {
        httpBody = try coder.encode(parameters)
        if let type = contentType {
            setValue(type, forHTTPHeaderField: "Content-Type")
        }
    }
    
    public mutating func encodeQuery<P: Encodable, C: TopLevelEncoder>(parameters: P, coder: C) throws where C.Output == String {
        let query = try coder.encode(parameters)
        if query.isEmpty {
            return
        }
        guard let preparedURL = url?.appendingQuery(query) else {
            throw URLError(.badURL)
        }
        url = preparedURL
    }

    public mutating func encodeQuery<P: Encodable, C: TopLevelEncoder>(parameters: P, coder: C) throws where C.Output == Data {
        let queryData = try coder.encode(parameters)
        if queryData.isEmpty {
            return
        }
        let query = String(decoding: queryData, as: Unicode.ASCII.self)
        guard let preparedURL = url?.appendingQuery(query) else {
            throw URLError(.badURL)
        }
        url = preparedURL
    }
}
