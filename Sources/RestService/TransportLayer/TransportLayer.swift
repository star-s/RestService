//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation

public protocol TransportLayer {
    associatedtype Request
    associatedtype Response

    func perform(_ request: Request, completion: @escaping (Result<(data: Data, response: Response), Error>) -> Void)
}
