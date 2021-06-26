//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 04.04.2021.
//

import Foundation

public protocol TopLevelEncoderProtocol {

    /// The type this encoder produces.
    associatedtype Output

    /// Encodes an instance of the indicated type.
    ///
    /// - Parameter value: The instance to encode.
    func encode<T: Encodable>(_ value: T) throws -> Self.Output
}

extension JSONEncoder: TopLevelEncoderProtocol {}
extension PropertyListEncoder: TopLevelEncoderProtocol {}
