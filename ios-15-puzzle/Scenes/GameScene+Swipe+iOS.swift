//
//  GameScene+Swipe+iOS.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 15/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import UIKit
import SpriteKit

// MARK: - Swipe gesture extnesion that iOS target
extension GameScene {
    
    // MARK: - Properties
    
    private static var isSwipeLocked: Bool = false
    
    // MARK: - Methods
    
    func prepareSwipeGestureRecognizers() {
        
        for direction in [UISwipeGestureRecognizer.Direction.right,
                          UISwipeGestureRecognizer.Direction.left,
                          UISwipeGestureRecognizer.Direction.up,
                          UISwipeGestureRecognizer.Direction.down] {
                            
                            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipe(_:)))
                            gesture.direction = direction
                            view?.addGestureRecognizer(gesture)
        }
        
    }
    
    @objc func swipe(_ gr: UISwipeGestureRecognizer) {
        guard !GameScene.isSwipeLocked else { return }
        
        let direction = Direction(direction: gr.direction)
        GameScene.isSwipeLocked = true
        
        let isValidSwipe = gameBoard?.resolveSwipe(for: direction) {
            GameScene.isSwipeLocked = false
            FeedbackGenerator.generate(for: .medium)
        }
        if let isValidSwipe = isValidSwipe, isValidSwipe {
            incrementMovesNumber()

            // Swipe is valid here, which means we can check whether the puzzle was solved or not
            if let isSolved = self.gameBoard?.isCorrect(), isSolved {
                print("Puzzle is Solved: ", isSolved)
                self.overlayManager?.state = .puzzleSolved
            }
        } else {
            GameScene.isSwipeLocked = false
        }
    }
}
