//
//  SlotNode.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 14/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import SpriteKit

class SlotNode: SKSpriteNode, Numberable, Slidable {
    
    // MARK: - Properties
    
    var number: UInt
    private var label: SKLabelNode?
    
    // MARK: - Initializers
    
    init(number: UInt, size: CGSize, textureName: String = "platformIndustrial_032") {
        self.number = number
        
        super.init(texture: SKTexture(imageNamed: textureName), color: .clear, size: size)
        
        let label = prepareLabel()
        addChild(label)
        
        self.label = label
        zPosition = ZPosition.cell.rawValue
        name = getStringRepresentation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func prepareLabel() -> SKLabelNode {
        let label = SKLabelNode(text: getStringRepresentation())
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        // TIP:
        // These constants are potentially dangerous, they need to be refactored
        label.position.x -= 10
        label.position.y += 10
        label.fontColor = .white
        label.fontSize = 50
        label.zPosition = ZPosition.cellLabel.rawValue
        return label
    }
}
