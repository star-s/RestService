//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 25.09.2021.
//

import Foundation

extension CodingUserInfoKey: ExpressibleByStringLiteral {
	public init(stringLiteral value: StaticString) {
		guard let key = CodingUserInfoKey(rawValue: value.description) else {
			preconditionFailure("Invalid key string: \(value)")
		}
		self = key
	}
}
