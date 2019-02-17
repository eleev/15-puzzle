//
//  NumberGenerator.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 15/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation

struct NumberGenerator: NumberGeneratorType {
    
    // MARK: - Properties
    
    private var reusableContainer: [UInt] = []
    private var numberRange: ClosedRange<UInt>
    var upperLimit: UInt
    
    // MARK: - Initialiezrs
    
    init(upperLimit: UInt) {
        self.upperLimit = upperLimit
        numberRange = 1...upperLimit
        
        numberRange.forEach { reusableContainer += [$0] }
    }
    
    // MARK: - Methods
    
    /// Generates an array that contains random, unique numbers within the accepted range
    // The implementation is based on Fisher-Yates/Knuth shuffle algorithm
    func generate() -> [UInt] {
        var numberContainer = reusableContainer
        
        for index in stride(from: numberContainer.count - 1, through: 1, by: -1) {
            let randomIndex = Int.random(in: 0...index)
            if index != randomIndex { numberContainer.swapAt(index, randomIndex) }
        }
        return numberContainer
    }
}
