//
//  NodeAnimator.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 15/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import SpriteKit

struct NodeAnimator {
    
    static func reveal(node: GenericNodeType, duration: TimeInterval) {
        node.alpha = 0.0
        let unhide = SKAction.fadeAlpha(to: 1.0, duration: duration)
        node.run(unhide)
    }
    
    static func alpha(node: SKSpriteNode, for alpha: CGFloat, duration: TimeInterval) {
        node.run(SKAction.fadeAlpha(to: alpha, duration: duration))
    }
    
    static func disappear(node: SKSpriteNode, for duration: TimeInterval) {
        let alpha = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let remove = SKAction.removeFromParent()
        let sequecne = SKAction.sequence([alpha, remove])
        node.run(sequecne)
    }
    
    struct ShuffleNode {
        
        static func fadeOut(node: SKSpriteNode?) {
            guard let node = node else { return }
            NodeAnimator.alpha(node: node, for: Constants.shuffleButtonDimLevel, duration: Constants.shuffleButtonDimAnimationDuration)
        }
        
        static func fadeIn(node: SKSpriteNode?) {
            guard let node = node else { return }
            NodeAnimator.alpha(node: node, for: 1.0, duration: Constants.shuffleButtonDimAnimationDuration)
        }
    }
}
