//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 04.04.2021.
//

import Foundation

extension URLSession: TransportLayer {
    
    public func perform(_ request: URLRequest, completion: @escaping (Result<(data: Data, response: URLResponse), Error>) -> Void) {
        dataTask(with: request) { (data, response, error) in
            completion(Result {
                if let error = error {
                    throw error
                }
                guard let response = response else {
                    throw URLError(.badServerResponse)
                }
                return (data ?? Data(), response)
            })
        }.resume()
    }
}
