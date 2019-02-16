//
//  SwipeOperation.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 16/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation

enum SwipeOperation {
    case adding(Int)
    case substracting(Int)
}

extension SwipeOperation {
    func getOperation() -> (Int, Int) -> Int {
        switch self {
        case .adding(_):
            return (+)
        case .substracting(_):
            return (-)
        }
    }
    
    func getValue() -> Int {
        switch self {
        case .adding(let value):
            return value
        case .substracting(let value):
            return value
        }
    }
}
