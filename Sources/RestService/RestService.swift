//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation
import Combine

public protocol RestService: ApplicationLayer {
    
    associatedtype Presenter: PresentationLayer
    var presenter: Presenter { get }
    
    associatedtype Transport: TransportLayer
    var transport: Transport { get }
    
    func url(for path: Path) -> AnyPublisher<URL, Error>
}

public extension RestService {
    
    func url(for path: Path) -> AnyPublisher<URL, Error> {
        path.urlPublisher()
    }

    func post<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        presenter.decode(presenter.validate(transport.perform(presenter.prepare(post: url(for: path), parameters: parameters))), decodingPath: decodingPath)
    }
    
    func get<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        presenter.decode(presenter.validate(transport.perform(presenter.prepare(get: url(for: path), parameters: parameters))), decodingPath: decodingPath)
    }
    
    func put<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        presenter.decode(presenter.validate(transport.perform(presenter.prepare(put: url(for: path), parameters: parameters))), decodingPath: decodingPath)
    }
    
    func patch<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        presenter.decode(presenter.validate(transport.perform(presenter.prepare(patch: url(for: path), parameters: parameters))), decodingPath: decodingPath)
    }
    
    func delete<P: Encodable, T: Decodable>(_ path: Path, parameters: P, decodingPath: [DecodingKey]? = nil) -> AnyPublisher<T, Error> {
        presenter.decode(presenter.validate(transport.perform(presenter.prepare(delete: url(for: path), parameters: parameters))), decodingPath: decodingPath)
    }
}

// MARK: -

public extension RestService where Self: PresentationLayer {
    var presenter: Self { self }
}

public extension RestService where Self: TransportLayer {
    var transport: Self { self }
}

