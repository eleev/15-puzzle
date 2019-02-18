//
//  PartiallyOrderedNumberGenerator.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 17/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation

/// Concrete implementation for NumberGeneratorType protocol that is used in mock tests
struct PartiallyOrderedNumberGenerator: NumberGeneratorType {
    
    // MARK: - Properties
    
    var upperLimit: UInt
    
    // MARK: - Initializers
    
    init(upperLimit: UInt = Constants.numberOfNodes) {
        self.upperLimit = upperLimit
    }
    
    // MARK: - Methods
    
    func generate() -> [UInt] {
        return [1,2,3,4,5,6,7,8,9,10,12,11,13,14,15]
    }
}
