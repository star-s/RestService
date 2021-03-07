//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 16.02.2021.
//

import Foundation

extension Decoder {
    
    func nestedContainer<K: CodingKey>(forDecodingPath keys: [K]) throws -> KeyedDecodingContainer<K> {
        try keys.reduce(container(keyedBy: K.self)) { try $0.nestedContainer(keyedBy: K.self, forKey: $1) }
    }

    func nestedContainerIfPresent<K: CodingKey>(forDecodingPath keys: [K]) -> KeyedDecodingContainer<K>? {
        do {
            return try nestedContainer(forDecodingPath: keys)
        } catch {
            return nil
        }
    }

    public func decode<T: Decodable, K: CodingKey>(_ type: T.Type, byDecodingPath keys: [K]) throws -> T {
        if keys.isEmpty {
            return try T.init(from: self)
        }
        var path = keys
        let key = path.removeLast()
        
        guard let OptionalT = T.self as? _OptionalProtocol.Type else {
            return try nestedContainer(forDecodingPath: path).decode(T.self, forKey: key)
        }
        guard let container = nestedContainerIfPresent(forDecodingPath: path) else {
            return OptionalT.init(nilLiteral: ()) as! T
        }
        guard let value = try? container.decode(T.self, forKey: key) else {
            return OptionalT.init(nilLiteral: ()) as! T
        }
        return value
    }
}

protocol _OptionalProtocol: ExpressibleByNilLiteral {}
extension Optional: _OptionalProtocol {}
