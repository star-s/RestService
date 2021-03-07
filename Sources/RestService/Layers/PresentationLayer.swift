//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation
import Combine

public protocol PresentationLayer {
    
    func prepare<T: Encodable, P: Publisher>(post   publisher: P, parameters: T) -> AnyPublisher<URLRequest, Error> where P.Output == URL, P.Failure == Error
    func prepare<T: Encodable, P: Publisher>(get    publisher: P, parameters: T) -> AnyPublisher<URLRequest, Error> where P.Output == URL, P.Failure == Error
    func prepare<T: Encodable, P: Publisher>(put    publisher: P, parameters: T) -> AnyPublisher<URLRequest, Error> where P.Output == URL, P.Failure == Error
    func prepare<T: Encodable, P: Publisher>(patch  publisher: P, parameters: T) -> AnyPublisher<URLRequest, Error> where P.Output == URL, P.Failure == Error
    func prepare<T: Encodable, P: Publisher>(delete publisher: P, parameters: T) -> AnyPublisher<URLRequest, Error> where P.Output == URL, P.Failure == Error

    func validate<P: Publisher>(_ publisher: P) -> AnyPublisher<Data, Error> where P.Output == (data: Data, response: URLResponse), P.Failure == Error

    func decode<T: Decodable, P: Publisher>(_ publisher: P, decodingPath: [DecodingKey]?) -> AnyPublisher<T, Error> where P.Output == Data, P.Failure == Error
}

public extension PresentationLayer {

    func prepare<T: Encodable, P: Publisher>(post publisher: P, parameters: T) -> AnyPublisher<URLRequest, Error> where P.Output == URL, P.Failure == Error {
        publisher.tryMap { try URLRequest("POST", url: $0, parameters: parameters, bodyCoder: JSONEncoder(), contentType: "application/json") }.eraseToAnyPublisher()
    }
    
    func prepare<T: Encodable, P: Publisher>(get publisher: P, parameters: T) -> AnyPublisher<URLRequest, Error> where P.Output == URL, P.Failure == Error {
        publisher.tryMap { try URLRequest(url: $0, parameters: parameters, queryCoder: URLEncodedFormEncoder()) }.eraseToAnyPublisher()
    }
    
    func prepare<T: Encodable, P: Publisher>(put publisher: P, parameters: T) -> AnyPublisher<URLRequest, Error> where P.Output == URL, P.Failure == Error {
        publisher.tryMap { try URLRequest("PUT", url: $0, parameters: parameters, bodyCoder: JSONEncoder(), contentType: "application/json") }.eraseToAnyPublisher()
    }
    
    func prepare<T: Encodable, P: Publisher>(patch publisher: P, parameters: T) -> AnyPublisher<URLRequest, Error> where P.Output == URL, P.Failure == Error {
        publisher.tryMap { try URLRequest("PATCH", url: $0, parameters: parameters, bodyCoder: JSONEncoder(), contentType: "application/json") }.eraseToAnyPublisher()
    }
    
    func prepare<T: Encodable, P: Publisher>(delete publisher: P, parameters: T) -> AnyPublisher<URLRequest, Error> where P.Output == URL, P.Failure == Error {
        publisher.tryMap { try URLRequest("DELETE", url: $0, parameters: parameters, queryCoder: URLEncodedFormEncoder()) }.eraseToAnyPublisher()
    }
    
    func validate<P: Publisher>(_ publisher: P) -> AnyPublisher<Data, Error> where P.Output == (data: Data, response: URLResponse), P.Failure == Error {
        publisher.tryMap() {
            guard let httpResponse = $0.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            return $0.data
        }.eraseToAnyPublisher()
    }

    func decode<T: Decodable, P: Publisher>(_ publisher: P, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> where P.Output == Data, P.Failure == Error {
        let coder = JSONDecoder()
        coder.valueDecodingPath = decodingPath
        return publisher.decode(type: DecodingPathAdapter<T>.self, decoder: coder).map({ $0.payload }).eraseToAnyPublisher()
    }
}
