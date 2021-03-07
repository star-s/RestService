//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 16.02.2021.
//

import Foundation

extension CodingUserInfoKey {
    public static let valueDecodingPath = CodingUserInfoKey(rawValue: "valueDecodingPath")!
}

extension JSONDecoder {
    
    public var valueDecodingPath: [DecodingKey]? {
        get { userInfo[.valueDecodingPath] as? [DecodingKey] }
        set { userInfo[.valueDecodingPath] = newValue }
    }
}

extension Decoder {
    
    public var valueDecodingPath: [DecodingKey] {
        guard codingPath.isEmpty else {
            return []
        }
        switch userInfo[.valueDecodingPath] {
        case let keys as [DecodingKey]:
            return keys
        case let keys as [CodingKey]:
            return keys.map { .key($0.stringValue) }
        case let keys as [String]:
            return keys.map { .key($0) }
        default:
            return []
        }
    }
}
