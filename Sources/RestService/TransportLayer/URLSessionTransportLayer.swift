//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 04.04.2021.
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol URLSessionTransportLayer: TransportLayer {
    var urlSession: URLSession { get }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public extension URLSessionTransportLayer {
    
    var urlSession: URLSession { .shared }

    func perform(_ request: URLRequest) async throws -> (data: Data, response: URLResponse) {
        try await urlSession.perform(request)
    }
}
