//
//  GameScene.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 14/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: - Properties
    
    private(set) var gameBoard: GameBoard?
    
    lazy private var movesLabel: SKLabelNode? = {
        return scene?.childNode(withName: "Moves Label") as? SKLabelNode
    }()
    
    private var numberOfMoves = 0 {
        didSet {
            let number = String(format: "Moves: %04d", numberOfMoves)
            movesLabel?.text = number
        }
    }
    
    // MARK: - Methods
    
    override func didMove(to view: SKView) {
        // Makes possible to extend the game in order to add another targets e.g.  `macOS` etc.
        #if os(iOS) || os(tvOS)
        prepareSwipeGestureRecognizers()
        #endif
        
        do {
            gameBoard = try GameBoard(scene: self)
            gameBoard?.prepare()
        } catch {
            print(error)
        }
    }
    
    func incrementMovesNumber() {
        numberOfMoves += 1
    }
}
