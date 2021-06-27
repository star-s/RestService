//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation

public protocol PresentationLayer {
    associatedtype Request
    associatedtype Response
    
    var defaultHeaders: HTTPHeaders { get }
    
    func prepare<T: Encodable>(post url: URL, parameters: T) throws -> Request
    func prepare<T: Encodable>(get url: URL, parameters: T) throws -> Request
    func prepare<T: Encodable>(put url: URL, parameters: T) throws -> Request
    func prepare<T: Encodable>(patch url: URL, parameters: T) throws -> Request
    func prepare<T: Encodable>(delete url: URL, parameters: T) throws -> Request
    
    func validate(data: Data, response: Response) throws -> Data

    func decode<T: Decodable>(data: Data, decodingPath: [DecodingKey]?) throws -> T
}
