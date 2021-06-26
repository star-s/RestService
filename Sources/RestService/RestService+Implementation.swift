//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.04.2021.
//

import Foundation

public extension RestService {

    func makeURL(from path: Path) throws -> URL {
        guard let url = URL(string: String(describing: path)) else {
            throw URLError(.badURL)
        }
        return url
    }
    
    func post<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let request = try presenter.prepare(post: makeURL(from: path), parameters: parameters)
            transport.perform(request) { [presenter] (result) in
                do {
                    let response = try result.get()
                    let data = try presenter.validate(data: response.data, response: response.response)
                    let value: T = try presenter.decode(data: data, decodingPath: decodingPath)
                    completion(.success(value))
                } catch {
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func get<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let request = try presenter.prepare(get: makeURL(from: path), parameters: parameters)
            transport.perform(request) { [presenter] (result) in
                do {
                    let response = try result.get()
                    let data = try presenter.validate(data: response.data, response: response.response)
                    let value: T = try presenter.decode(data: data, decodingPath: decodingPath)
                    completion(.success(value))
                } catch {
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func put<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let request = try presenter.prepare(put: makeURL(from: path), parameters: parameters)
            transport.perform(request) { [presenter] (result) in
                do {
                    let response = try result.get()
                    let data = try presenter.validate(data: response.data, response: response.response)
                    let value: T = try presenter.decode(data: data, decodingPath: decodingPath)
                    completion(.success(value))
                } catch {
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func patch<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let request = try presenter.prepare(patch: makeURL(from: path), parameters: parameters)
            transport.perform(request) { [presenter] (result) in
                do {
                    let response = try result.get()
                    let data = try presenter.validate(data: response.data, response: response.response)
                    let value: T = try presenter.decode(data: data, decodingPath: decodingPath)
                    completion(.success(value))
                } catch {
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let request = try presenter.prepare(delete: makeURL(from: path), parameters: parameters)
            transport.perform(request) { [presenter] (result) in
                do {
                    let response = try result.get()
                    let data = try presenter.validate(data: response.data, response: response.response)
                    let value: T = try presenter.decode(data: data, decodingPath: decodingPath)
                    completion(.success(value))
                } catch {
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}

public extension RestService where Self: PresentationLayer {
    var presenter: Self { self }
}

public extension RestService where Self: TransportLayer {
    var transport: Self { self }
}
