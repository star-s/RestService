//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 16.02.2021.
//

import Foundation

public struct Path {
    let path: String
}

public extension Path {
    
    func appendingPath(suffix aPath: String) -> Self {
        Path((path as NSString).appendingPathComponent(aPath))
    }
    
    func appendingPath(prefix aPath: String) -> Self {
        Path((aPath as NSString).appendingPathComponent(path))
    }
}

extension Path: Hashable {}

public extension Path {

    static func + (lhs: Path, rhs: Path) -> Path {
        lhs.appendingPath(suffix: rhs.path)
    }

    static func + <T: CustomStringConvertible>(lhs: Path, rhs: T) -> Path {
        lhs.appendingPath(suffix: rhs.description)
    }

    static func + <T: CustomStringConvertible>(lhs: T, rhs: Path) -> Path {
        rhs.appendingPath(prefix: lhs.description)
    }
}

// MARK: - LosslessStringConvertible

extension Path: LosslessStringConvertible {
    
    public var description: String {
        path
    }
    
    public init(_ description: String) {
        path = description
    }
}

// MARK: - ExpressibleByStringLiteral

extension Path: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        guard let pathString = Scanner(string: value).scanUpToCharacters(from: CharacterSet(charactersIn: "!$&'()*+,;=")) else {
            preconditionFailure("Invalid path string: \(value)")
        }
        path = pathString
    }
}

// MARK: -

import Combine

extension Path {
    
    public func urlPublisher(relativeTo baseURL: URL? = nil) -> AnyPublisher<URL, Error> {
        Future { (promise) in
            if let url = URL(string: path, relativeTo: baseURL) {
                promise(.success(url))
            } else {
                promise(.failure(URLError(.badURL)))
            }
        }.eraseToAnyPublisher()
    }
}
