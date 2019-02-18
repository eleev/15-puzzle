//
//  Constants.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 15/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import CoreGraphics
import SpriteKit

struct Constants {
    // Standard node cell size
    static let cellSize = CGSize(width: 124, height: 124)
    // Since the game for 16 cell nodes, the upper limit is the 15 (16 - 1). This constant will be used in node generation, as well
    static let numberOfNodes: UInt = 15
    
    static let shuffleCellsInitially: UInt = 15
    static let shuffleCellsByTap: UInt = 400
    
    static let shuffleButtonName = "Shuffle Button"
    static let movesLabelName = "Moves Label"
    
    static let movesFormatter = "%04d"
    static let movesIncrementor = 1
    
    static let shuffleButtonDimLevel: CGFloat = 0.35
    static let shuffleButtonDimAnimationDuration = 0.25
    
    struct SlideAnimation {
        static let defaultDuration = 0.2
        static let fastShufflingDuration = 0.0
    }
    
    struct OverlayManager {
        static let gameOverScene = "GameOverScene"
        static let puzzleSolvedScene = "PuzzleSolvedScene"
        static let overlay = "Background Overlay"
        static let appearenceDuration: TimeInterval = 1.0
    }
    
    struct GameOverState {
        static let timer: (minutes: Int, seconds: Int) = (59, 59)
        static let moves = 9999
    }
    
    struct SlotNode {
        struct Font {
            static let shift: CGFloat = 10
            static let size: CGFloat = 48
            static let name = "HelveticaNeue"
            static let type = "-Regular"
            static let color: SKColor = .white
        }
        static let texture = "platformIndustrial_032"
    }
    
    struct TimeLabel {
        static let name = "Time Label"
        static let formatter = "%02d:%02d"
    }
    
    enum GameSceneType: String {
        case phone = "GameScene-iPhone"
        case pad = "GameScene-iPad"
    }
    
    enum ZPosition: CGFloat {
        case cell = 10.0
        case cellLabel = 5.0
        case overlay = 200.0
    }
}
