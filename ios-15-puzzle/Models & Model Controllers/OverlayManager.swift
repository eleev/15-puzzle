//
//  OverlayManager.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 17/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import SpriteKit

class OverlayManager {
    
    // MARK: - Enum types
    
    enum OverlayState {
        case puzzleSolved
        case gameOver
        case none
    }
    
    // MARK: - Properties
    
    lazy private var gameOverOverlayNode: SKSpriteNode? = {
        let scene = SKScene(fileNamed: Constants.OverlayManager.gameOverScene)
        let background = scene?.childNode(withName: Constants.OverlayManager.overlay) as? SKSpriteNode
        
        background?.removeFromParent()
        return background
    }()
    
    lazy private var puzzleSolvedOverlayNode: SKSpriteNode? = {
        let scene = SKScene(fileNamed: Constants.OverlayManager.puzzleSolvedScene)
        let background = scene?.childNode(withName: Constants.OverlayManager.overlay) as? SKSpriteNode
        
        background?.removeFromParent()
        return background
    }()
    
    private weak var scene: GameScene?
    
    var state: OverlayState = .none {
        didSet {
            switch state {
            case .none:
                cleanUpOverlays()
            case .gameOver:
                presentOverlay(node: gameOverOverlayNode)
            case .puzzleSolved:
                presentOverlay(node: puzzleSolvedOverlayNode)
            }
        }
    }
    
    // MARK: - Initializers
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    // MARK: - Methods
    
    private func presentOverlay(node: SKSpriteNode?) {
        cleanUpOverlays()
        
        guard let overlay = node else { return }
        overlay.alpha = 1.0
        scene?.addChild(overlay)
        
        scene?.timer.stop()
                
        #if os(iOS) || os(tvOS)
        scene?.view?.gestureRecognizers = nil
        #endif
    }
    
    private func cleanUpOverlays() {
        puzzleSolvedOverlayNode?.removeFromParent()
        gameOverOverlayNode?.removeFromParent()
        
        #if os(iOS) || os(tvOS)
        scene?.prepareSwipeGestureRecognizers()
        #endif
    }
}
