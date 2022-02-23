//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 04.04.2021.
//

import Foundation

public protocol URLSessionTransportLayer: TransportLayer {
    var urlSession: URLSession { get }
}

public extension URLSessionTransportLayer {
    
    var urlSession: URLSession { .shared }

    func perform(_ request: URLRequest, completion: @escaping (Result<(data: Data, response: URLResponse), Error>) -> Void) {
        urlSession.perform(request, completion: completion)
    }
}
