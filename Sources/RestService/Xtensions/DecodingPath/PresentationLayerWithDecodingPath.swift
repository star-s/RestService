//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2022.
//

import Foundation

public protocol PresentationLayerWithDecodingPath: PresentationLayer {
	func decode<T: Decodable>(data: Data, decodingPath: [DecodingKey]?) throws -> T
}

public extension PresentationLayerWithDecodingPath {
	
	func decode<T: Decodable>(data: Data) throws -> T {
		try decode(data: data, decodingPath: nil)
	}
	
	func decode<T: Decodable>(data: Data, decodingPath: [DecodingKey]?) throws -> T {
		if (decodingPath ?? []).isEmpty {
			return try Super().decode(data: data)
		}
		let coder = JSONDecoder()
		coder.valueDecodingPath = decodingPath
		return try coder.decode(DecodingPathAdapter<T>.self, from: data).payload
	}
}

private struct Super: PresentationLayer {}
