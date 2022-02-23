//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2022.
//

import Foundation

public protocol PresentationLayerWithCustomHeaders: PresentationLayer {
	var headers: HTTPHeaders { get }
}

public extension PresentationLayerWithCustomHeaders {
	
	func prepare<T: Encodable>(post url: URL, parameters: T) throws -> URLRequest {
		try URLRequest(url: url)
			.settingHeaders(headers)
			.settingMethod(.post)
			.encodingBody(parameters, coder: JSONEncoder(), contentType: "application/json")
	}
	
	func prepare<T: Encodable>(get url: URL, parameters: T) throws -> URLRequest {
		try URLRequest(url: url)
			.settingHeaders(headers)
			.encodingQuery(parameters, coder: URLEncodedFormEncoder())
	}
	
	func prepare<T: Encodable>(put url: URL, parameters: T) throws -> URLRequest {
		try URLRequest(url: url)
			.settingHeaders(headers)
			.settingMethod(.put)
			.encodingBody(parameters, coder: JSONEncoder(), contentType: "application/json")
	}
	
	func prepare<T: Encodable>(patch url: URL, parameters: T) throws -> URLRequest {
		try URLRequest(url: url)
			.settingHeaders(headers)
			.settingMethod(.patch)
			.encodingBody(parameters, coder: JSONEncoder(), contentType: "application/json")
	}
	
	func prepare<T: Encodable>(delete url: URL, parameters: T) throws -> URLRequest {
		try URLRequest(url: url)
			.settingHeaders(headers)
			.settingMethod(.delete)
			.encodingQuery(parameters, coder: URLEncodedFormEncoder())
	}
}
