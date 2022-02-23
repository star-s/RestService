//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation

public protocol RestService: ApplicationLayer {
    
    associatedtype Presenter: PresentationLayer
    var presenter: Presenter { get }
    
    associatedtype Transport: TransportLayer
    var transport: Transport { get }
    
    func makeURL(from path: Path) throws -> URL
}

public extension RestService where Self: PresentationLayer {
	var presenter: Self { self }
}

public extension RestService where Self: TransportLayer {
	var transport: Self { self }
}

public extension RestService {

	func makeURL(from path: Path) throws -> URL {
		guard let url = URL(string: String(describing: path)) else {
			throw URLError(.badURL)
		}
		return url
	}
	
	func post<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let request = try presenter.prepare(post: makeURL(from: path), parameters: parameters)
			transport.perform(request) { [presenter] (result) in
				completion(Result {
					let response = try result.get()
					let data = try presenter.validate(data: response.data, response: response.response)
					return try presenter.decode(data: data)
				})
			}
		} catch {
			completion(.failure(error))
		}
	}
	
	func get<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let request = try presenter.prepare(get: makeURL(from: path), parameters: parameters)
			transport.perform(request) { [presenter] (result) in
				completion(Result {
					let response = try result.get()
					let data = try presenter.validate(data: response.data, response: response.response)
					return try presenter.decode(data: data)
				})
			}
		} catch {
			completion(.failure(error))
		}
	}
	
	func put<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let request = try presenter.prepare(put: makeURL(from: path), parameters: parameters)
			transport.perform(request) { [presenter] (result) in
				completion(Result {
					let response = try result.get()
					let data = try presenter.validate(data: response.data, response: response.response)
					return try presenter.decode(data: data)
				})
			}
		} catch {
			completion(.failure(error))
		}
	}
	
	func patch<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let request = try presenter.prepare(patch: makeURL(from: path), parameters: parameters)
			transport.perform(request) { [presenter] (result) in
				completion(Result {
					let response = try result.get()
					let data = try presenter.validate(data: response.data, response: response.response)
					return try presenter.decode(data: data)
				})
			}
		} catch {
			completion(.failure(error))
		}
	}
	
	func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let request = try presenter.prepare(delete: makeURL(from: path), parameters: parameters)
			transport.perform(request) { [presenter] (result) in
				completion(Result {
					let response = try result.get()
					let data = try presenter.validate(data: response.data, response: response.response)
					return try presenter.decode(data: data)
				})
			}
		} catch {
			completion(.failure(error))
		}
	}
}
