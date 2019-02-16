//
//  NumberGeneratorType.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 16/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation

protocol NumberGeneratorType {
    
    // MARK: - Properties
    
    var upperLimit: UInt { get }
    
    // MARK: - Initializers
    
    init(upperLimit: UInt)
    
    // MARK: - Methods
    
    func generate() -> [UInt]
}
