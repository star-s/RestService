//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation

public protocol PresentationLayer {
    
    var defaultHeaders: HTTPHeaders { get }
    
    func prepare<T: Encodable>(post url: URL, parameters: T) throws -> URLRequest
    func prepare<T: Encodable>(get url: URL, parameters: T) throws -> URLRequest
    func prepare<T: Encodable>(put url: URL, parameters: T) throws -> URLRequest
    func prepare<T: Encodable>(patch url: URL, parameters: T) throws -> URLRequest
    func prepare<T: Encodable>(delete url: URL, parameters: T) throws -> URLRequest
    
    func validate(data: Data, response: URLResponse) throws -> Data

    func decode<T: Decodable>(data: Data, decodingPath: [DecodingKey]?) throws -> T
}
