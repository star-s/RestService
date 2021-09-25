//
//  URL.swift
//
//
//  Created by Sergey Starukhin on 18/09/2019.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: StaticString) {
		guard let url = URL(string: value.description) else {
            preconditionFailure("Invalid URL string: \(value)")
        }
        self = url
    }
}

extension URL {
    
    public func appendingQuery(_ query: String, percentEncoded: Bool = true) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        if percentEncoded {
            components.percentEncodedQuery = query
        } else {
            components.query = query
        }
        guard let result = components.url else {
            return nil
        }
        return result
    }
}
