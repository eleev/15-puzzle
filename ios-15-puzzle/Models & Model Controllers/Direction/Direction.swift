//
//  Direction.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 15/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation

enum Direction: String {
    case left, right, up, down, none
}

extension Direction {
    
    func opposite() -> Direction {
        switch self {
        case .up:
            return .down
        case .down:
            return .up
        case .left:
            return .right
        case .right:
            return .left
        case .none:
            return self
        }
    }
    
    static func random() -> Direction {
        switch (Bool.random(), Bool.random()) {
        case (false, false):
            return .down
        case (true, true):
            return .up
        case (false, true):
            return .right
        case (true, false):
            return .left
        }
    }
    
    static func random(excluding direction: Direction) -> Direction? {
        var directions: [String : Direction] = ["up" : .up, "down" : .down, "left" : .left, "right" : .right]
        directions.removeValue(forKey: direction.opposite().rawValue)
        return directions.randomElement()?.value
    }
    
    static func generate(_ number: UInt) -> [Direction] {
        var directions = [Direction]()
        directions += [random()]
        
        (1...number).forEach { index in
            let previousIndex = Int(index - 1)
            let previousDirection = directions[previousIndex]
            
            if let oppositeDirection = Direction.random(excluding: previousDirection) {
                directions += [oppositeDirection]
            }
        }
        return directions
    }
}
