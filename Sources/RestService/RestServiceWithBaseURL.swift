//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 07.03.2021.
//

import Foundation
import Combine

public protocol RestServiceWithBaseURL: RestService {
    var baseURL: URL { get }
}

public extension RestServiceWithBaseURL {
    
    func url(for path: Path) -> AnyPublisher<URL, Error> {
        path.urlPublisher(relativeTo: baseURL)
    }
}
