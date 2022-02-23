//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation

public protocol PresentationLayer {
    
    func prepare<T: Encodable>(post url: URL, parameters: T) throws -> URLRequest
    func prepare<T: Encodable>(get url: URL, parameters: T) throws -> URLRequest
    func prepare<T: Encodable>(put url: URL, parameters: T) throws -> URLRequest
    func prepare<T: Encodable>(patch url: URL, parameters: T) throws -> URLRequest
    func prepare<T: Encodable>(delete url: URL, parameters: T) throws -> URLRequest
    
    func validate(data: Data, response: URLResponse) throws -> Data

    func decode<T: Decodable>(data: Data) throws -> T
}

public extension PresentationLayer {
	
	func prepare<T: Encodable>(post url: URL, parameters: T) throws -> URLRequest {
		try URLRequest(url: url)
			.settingHeaders()
			.settingMethod(.post)
			.encodingBody(parameters, coder: JSONEncoder(), contentType: "application/json")
	}
	
	func prepare<T: Encodable>(get url: URL, parameters: T) throws -> URLRequest {
		try URLRequest(url: url)
			.settingHeaders()
			.encodingQuery(parameters, coder: URLEncodedFormEncoder())
	}
	
	func prepare<T: Encodable>(put url: URL, parameters: T) throws -> URLRequest {
		try URLRequest(url: url)
			.settingHeaders()
			.settingMethod(.put)
			.encodingBody(parameters, coder: JSONEncoder(), contentType: "application/json")
	}
	
	func prepare<T: Encodable>(patch url: URL, parameters: T) throws -> URLRequest {
		try URLRequest(url: url)
			.settingHeaders()
			.settingMethod(.patch)
			.encodingBody(parameters, coder: JSONEncoder(), contentType: "application/json")
	}
	
	func prepare<T: Encodable>(delete url: URL, parameters: T) throws -> URLRequest {
		try URLRequest(url: url)
			.settingHeaders()
			.settingMethod(.delete)
			.encodingQuery(parameters, coder: URLEncodedFormEncoder())
	}
	
	func validate(data: Data, response: URLResponse) throws -> Data {
		guard (response as? HTTPURLResponse)?.statusCode == 200 else {
			throw URLError(.badServerResponse)
		}
		return data
	}

	func decode<T: Decodable>(data: Data) throws -> T {
		if T.self is Data.Type {
			return data as! T
		}
		return try JSONDecoder().decode(T.self, from: data)
	}
}
