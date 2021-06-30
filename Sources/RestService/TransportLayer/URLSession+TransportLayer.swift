//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 04.04.2021.
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension URLSession: TransportLayer {
    
    public func perform(_ request: URLRequest) async throws -> (data: Data, response: URLResponse) {
        try await data(for: request, delegate: nil)
    }
}
