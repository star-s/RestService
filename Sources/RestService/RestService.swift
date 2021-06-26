//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 23.02.2021.
//

import Foundation

public protocol RestService: ApplicationLayer {
    
    associatedtype Presenter: PresentationLayer
    var presenter: Presenter { get }
    
    associatedtype Transport: TransportLayer
    var transport: Transport { get }
    
    func makeURL(from path: Path) throws -> URL
}
