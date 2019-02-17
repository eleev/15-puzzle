//
//  CellNode.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 14/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import SpriteKit

class CellNode: SKSpriteNode, Numberable, Slidable {
    
    // MARK: - Properties
    
    var number: UInt
    
    // MARK: - Initializers
    
    init(number: UInt, size: CGSize, textureName: String = Constants.SlotNode.texture) {
        self.number = number
        
        super.init(texture: SKTexture(imageNamed: textureName), color: .clear, size: size)
        
        let label = prepareLabel()
        addChild(label)
        
        zPosition = Constants.ZPosition.cell.rawValue
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

        let shift = Constants.SlotNode.Font.shift
        label.position.x -= shift
        label.position.y += shift
        
        if let fontName = label.fontName {
            label.fontName = fontName + Constants.SlotNode.Font.type
        }
        
        label.fontColor = Constants.SlotNode.Font.color
        label.fontSize = Constants.SlotNode.Font.size
        label.zPosition = Constants.ZPosition.cellLabel.rawValue
        return label
    }
}
