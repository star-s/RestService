//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 13.04.2021.
//

import Foundation

public protocol DefaultTransport {
    var transport: URLSession { get }
}

public extension DefaultTransport {
    var transport: URLSession { .shared }
}
