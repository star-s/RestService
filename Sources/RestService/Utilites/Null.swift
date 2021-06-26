//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation

public typealias Null = Optional<Empty>
public struct Empty: Decodable {}

extension Empty: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {}
}
