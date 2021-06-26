//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation

public protocol TransportLayer {
    func perform(_ request: URLRequest, completion: @escaping (Result<(data: Data, response: URLResponse), Error>) -> Void)
}
