//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation
import Combine

public protocol TransportLayer {
    func perform<P: Publisher>(_ publisher: P) -> AnyPublisher<(data: Data, response: URLResponse), Error> where P.Output == URLRequest, P.Failure == Error
}
