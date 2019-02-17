//
//  Slidable.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 15/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import CoreGraphics
import SpriteKit

protocol Slidable: class {
    func slide(to position: CGPoint, for duration: TimeInterval, completion: @escaping () -> Void)
}

extension Slidable where Self: SKSpriteNode {
    func slide(to position: CGPoint, for duration: TimeInterval = 0.2, completion: @escaping () -> Void) {
        let moveAction = SKAction.move(to: position, duration: duration)
        run(moveAction, completion: completion)
    }
}
