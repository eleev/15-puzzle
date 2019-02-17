//
//  NodeFactory.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 15/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import CoreGraphics

struct NodeFactory {
    
    static func produce(of type: NodeType, position: CGPoint) -> GenericNodeType {
        switch type {
        case .slot(let number):
            let node = CellNode(number: number, size: Constants.cellSize)
            node.position = position
            return node
        }
    }
}
