//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation
import Combine

public protocol URLSessionTransportLayer: TransportLayer {
    var urlSession: URLSession { get }
}

public extension URLSessionTransportLayer {
    
    var urlSession: URLSession { .shared }
    
    func perform<P: Publisher>(_ publisher: P) -> AnyPublisher<(data: Data, response: URLResponse), Error> where P.Output == URLRequest, P.Failure == Error {
        publisher.flatMap { urlSession.dataTaskPublisher(for: $0).mapError { $0 } }.eraseToAnyPublisher()
    }
}
