//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 26.06.2021.
//

import Foundation

public extension PresentationLayer {
    
    func prepare<T: Encodable>(post url: URL, parameters: T) throws -> URLRequest {
        try URLRequest(url: url).settingHeaders().settingMethod(.post).encodingBody(parameters, coder: JSONEncoder(), contentType: "application/json")
    }
    
    func prepare<T: Encodable>(get url: URL, parameters: T) throws -> URLRequest {
        try URLRequest(url: url).settingHeaders().encodingQuery(parameters, coder: URLEncodedFormEncoder())
    }
    
    func prepare<T: Encodable>(put url: URL, parameters: T) throws -> URLRequest {
        try URLRequest(url: url).settingHeaders().settingMethod(.put).encodingBody(parameters, coder: JSONEncoder(), contentType: "application/json")
    }
    
    func prepare<T: Encodable>(patch url: URL, parameters: T) throws -> URLRequest {
        try URLRequest(url: url).settingHeaders().settingMethod(.patch).encodingBody(parameters, coder: JSONEncoder(), contentType: "application/json")
    }
    
    func prepare<T: Encodable>(delete url: URL, parameters: T) throws -> URLRequest {
        try URLRequest(url: url).settingHeaders().settingMethod(.delete).encodingQuery(parameters, coder: URLEncodedFormEncoder())
    }
    
    func validate(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }

    func decode<T: Decodable>(data: Data, decodingPath: [DecodingKey]?) throws -> T {
        let coder = JSONDecoder()
        coder.valueDecodingPath = decodingPath
        return try coder.decode(DecodingPathAdapter<T>.self, from: data).payload
    }
}
