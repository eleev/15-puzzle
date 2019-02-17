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
    
    lazy private var timerLabel: SKLabelNode? = {
        return scene?.childNode(withName: Constants.TimeLabel.name) as? SKLabelNode
    }()
    
    lazy private var movesLabel: SKLabelNode? = {
        return scene?.childNode(withName: Constants.movesLabelName) as? SKLabelNode
    }()
    
    private var numberOfMoves = 0 {
        didSet {
            let number = String(format: Constants.movesFormatter, numberOfMoves)
            movesLabel?.text = number
        }
    }
    
    lazy private var shuffleButton: SKSpriteNode? = {
        return scene?.childNode(withName: Constants.shuffleButtonName) as? SKSpriteNode
    }()
    
    lazy private(set) var timer: Timer = {
        return Timer()
    }()

    lazy private(set) var overlayManager: OverlayManager? = {
        return OverlayManager(scene: self)
    }()
    
    // MARK: - Methods
    
    override func didMove(to view: SKView) {
        // Makes possible to extend the game in order to add another targets e.g.  `macOS` etc.
        #if os(iOS) || os(tvOS)
        prepareSwipeGestureRecognizers()
        #endif
        
        let defaultGenerator: NumberGeneratorType = NumberGenerator(upperLimit: Constants.numberOfNodes)
        
        // NOTE: The following commented code needs to be removed
        // Mock number generator for testing purposes
//        defaultGenerator = OrderedNumberGeneratorMock()
        
        do {
            gameBoard = try GameBoard(scene: self, numberGenerator: defaultGenerator)
            gameBoard?.prepare()
        } catch {
            print(error)
        }
        
        shuffleGameBoard(for: Constants.shuffleCellsInitially)
    }
    
    func incrementMovesNumber() {
        if Constants.GameOverState.moves == numberOfMoves {
            // Trigger Game Over state
            overlayManager?.state = .gameOver
        } else {
            numberOfMoves += Constants.movesIncrementor
        }
    }
    
    func resetMoves() {
        numberOfMoves = 0
    }
    
    private func updateTimeLabel() {
        timer.start { [weak self] _, m, s in
            if Constants.GameOverState.timer == (m, s) {
                self?.overlayManager?.state = .gameOver
            } else {
                self?.timerLabel?.text = String(format: Constants.TimeLabel.formatter, m, s)
            }
        }
    }
    
    private func shuffleGameBoard(for times: UInt) {
        shuffleGameBoard(for: times) { [weak self] in
            self?.updateTimeLabel()
        }
    }
    
    private func shuffleGameBoard(for times: UInt, compeltion: @escaping () -> Void = { /*  default, empty closure */ }) {
        view?.isUserInteractionEnabled = false
        
        let directions = Direction.generateNonRepeating(times)
        NodeAnimator.ShuffleNode.fadeOut(node: shuffleButton)

        gameBoard?.shuffle(using: directions, iteration: {
            FeedbackGenerator.generate(for: .light)
        }, completion: { [weak self] in
            self?.view?.isUserInteractionEnabled = true
            NodeAnimator.ShuffleNode.fadeIn(node: self?.shuffleButton)
            self?.gameBoard?.slideAnimationDuration = Constants.SlideAnimation.defaultDuration
            
            compeltion()
        })
    }
}

#if os(iOS) || os(tvOS)
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let touchedNodes = nodes(at: location)
        
        for node in touchedNodes where node.name == shuffleButton?.name {
            overlayManager?.state = .none
            timer.stop()
            timer.reset()
            resetMoves()
            
            gameBoard?.slideAnimationDuration = Constants.SlideAnimation.fastShufflingDuration
            shuffleGameBoard(for: Constants.shuffleCellsByTap)
            return
        }
    }
}
#endif
