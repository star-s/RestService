//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2022.
//

import Foundation

public protocol RestServiceWithDecodingPath: RestService where Presenter: PresentationLayerWithDecodingPath {
	func post<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void)
	func get<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void)
	func put<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void)
	func patch<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void)
	func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]?, completion: @escaping (Result<T, Error>) -> Void)
}

public extension RestServiceWithDecodingPath {
	
	func post<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
		post(path, parameters: parameters, decodingPath: nil, completion: completion)
	}
	
	func get<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
		get(path, parameters: parameters, decodingPath: nil, completion: completion)
	}
	
	func put<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
		put(path, parameters: parameters, decodingPath: nil, completion: completion)
	}
	
	func patch<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
		patch(path, parameters: parameters, decodingPath: nil, completion: completion)
	}
	
	func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
		delete(path, parameters: parameters, decodingPath: nil, completion: completion)
	}

	// MARK: -
	
	func post<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let request = try presenter.prepare(post: makeURL(from: path), parameters: parameters)
			transport.perform(request) { [presenter] (result) in
				completion(Result {
					let response = try result.get()
					let data = try presenter.validate(data: response.data, response: response.response)
					return try presenter.decode(data: data, decodingPath: decodingPath)
				})
			}
		} catch {
			completion(.failure(error))
		}
	}
	
	func get<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let request = try presenter.prepare(get: makeURL(from: path), parameters: parameters)
			transport.perform(request) { [presenter] (result) in
				completion(Result {
					let response = try result.get()
					let data = try presenter.validate(data: response.data, response: response.response)
					return try presenter.decode(data: data, decodingPath: decodingPath)
				})
			}
		} catch {
			completion(.failure(error))
		}
	}
	
	func put<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let request = try presenter.prepare(put: makeURL(from: path), parameters: parameters)
			transport.perform(request) { [presenter] (result) in
				completion(Result {
					let response = try result.get()
					let data = try presenter.validate(data: response.data, response: response.response)
					return try presenter.decode(data: data, decodingPath: decodingPath)
				})
			}
		} catch {
			completion(.failure(error))
		}
	}
	
	func patch<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let request = try presenter.prepare(patch: makeURL(from: path), parameters: parameters)
			transport.perform(request) { [presenter] (result) in
				completion(Result {
					let response = try result.get()
					let data = try presenter.validate(data: response.data, response: response.response)
					return try presenter.decode(data: data, decodingPath: decodingPath)
				})
			}
		} catch {
			completion(.failure(error))
		}
	}
	
	func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let request = try presenter.prepare(delete: makeURL(from: path), parameters: parameters)
			transport.perform(request) { [presenter] (result) in
				completion(Result {
					let response = try result.get()
					let data = try presenter.validate(data: response.data, response: response.response)
					return try presenter.decode(data: data, decodingPath: decodingPath)
				})
			}
		} catch {
			completion(.failure(error))
		}
	}
}
