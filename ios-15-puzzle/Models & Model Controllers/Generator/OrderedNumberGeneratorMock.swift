//
//  OrderedNumberGeneratorMock.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 16/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation

/// Mock ordered number generator type for tests
struct OrderedNumberGeneratorMock: NumberGeneratorType {
    
    // MARK: - Properties
    
    var upperLimit: UInt
    
    // MARK: - Initializers
    
    init(upperLimit: UInt = Constants.numberOfNodes) {
        self.upperLimit = upperLimit
    }
    
    // MARK: - Methods
    
    func generate() -> [UInt] {
        return Array((1...upperLimit))
    }
}
