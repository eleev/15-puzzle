//
//  GameBoard.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 15/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation
import SpriteKit

class GameBoard {
    
    // MARK: - Properties
    
    private(set) var nodeSlots: [SKNode]
    private(set) var swipableCells = [[GenericNodeType]](repeating: [], count: Int(Constants.numberOfNodes + 1))
    
    private var generator: NumberGenerator
    private weak var scene: SKScene?
    private let indexBoundary = Int(sqrt(Double(Constants.numberOfNodes + 1)))
    private var emptySlotIndexPair = (i: 0, j: 0)

    // MARK: - Initializes
    
    init(scene: SKScene) throws {
        self.scene = scene
        generator = NumberGenerator(upperLimit: Constants.numberOfNodes)
        
        nodeSlots = scene.children.filter { $0.name?.contains("Slot Node") ?? false }
        let cells = nodeSlots.count
        
        guard cells == Constants.numberOfNodes + 1 else {
            throw GameBoardError.invalidNumberOf(cells: UInt(cells), message: "Make sure that the number of node slots on the game board scene (.sks) is the same as it was declared in configuration")
        }
    }
    
    // MARK: - Methods
    
    /// Prepares the game board for the session
    /// Time complexity is O(n)
    func prepare() {
        swipableCells = [[GenericNodeType]](repeating: [], count: Int(Constants.numberOfNodes + 1))
        
        let numbers = generator.generate()
        var i = 0, j = 0

        for (index, number) in numbers.enumerated() {
            let node = nodeSlots[index]
            let cell = NodeFactory.produce(of: .slot(numbered: number), position: node.position)
            
            swipableCells[i].append(cell)
            
            if j == indexBoundary - 1 {
                j = 0
                i += 1
            } else { j += 1 }
            
            NodeAnimator.reveal(node: cell, duration: 1.0)
            scene?.addChild(cell)
        }
        
        func prepareEmptySlot() {
            // Represents an empty node
            let emptyCell = SlotNode(number: 0, size: .zero)
            emptyCell.position = nodeSlots.last?.position ?? .zero
            swipableCells[i].append(emptyCell)
            
            // Remember the index pair for the empty slot
            emptySlotIndexPair = (i, swipableCells[i].count - 1)
        }
        
        prepareEmptySlot()
    }
    
    
    /// Utility method for testing purposes. Checks whether the board contains a node by a certain name
    /// Time complexity is O(n * 2)
    func node(named name: String) -> (i: Int, j: Int, node: GenericNodeType)? {
        for (i, row) in swipableCells.enumerated() {
            for (j, node) in row.enumerated() where node.name == name{
                return (i, j, node)
            }
        }
        return nil
    }
    
    /// Resolves all the movement for O(n) time by applying swap function for the nodes
    func resolveSwipe(for direction: Direction, completion: @escaping () -> Void) -> Bool {
        var hasPerformedSwipe = false
        
        switch direction {
        case .right:
            let index = emptySlotIndexPair.j - 1
            guard index >= 0 else { return false }
            
            // Swap the model positions of the cells
            let empty = swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j]
            
            let cell = swipableCells[emptySlotIndexPair.i][index]
            
            swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j] = swipableCells[emptySlotIndexPair.i][index]
            swipableCells[emptySlotIndexPair.i][index] = empty
            emptySlotIndexPair.j -= 1
            
            // Swap the positions of the cells
            let emptyPosition = empty.position
            empty.position = cell.position
            cell.slide(to: emptyPosition, completion: completion)
            
            hasPerformedSwipe = true
        case .up:
            let index = emptySlotIndexPair.i + 1
            guard index < indexBoundary else { return false }
            
            // Swap the model positions of the cells
            let empty = swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j]
            let cell = swipableCells[index][emptySlotIndexPair.j]
            
            swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j] = swipableCells[index][emptySlotIndexPair.j]
            swipableCells[index][emptySlotIndexPair.j] = empty
            emptySlotIndexPair.i += 1
            
            // Swap the positions of the cells
            let emptyPosition = empty.position
            empty.position = cell.position
            cell.slide(to: emptyPosition, completion: completion)
            
            hasPerformedSwipe = true
        case .left:
            let index = emptySlotIndexPair.j + 1
            guard index < indexBoundary else { return false }
            
            // Swap the model positions of the cells
            let empty = swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j]
            let cell = swipableCells[emptySlotIndexPair.i][index]
            
            swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j] = swipableCells[emptySlotIndexPair.i][index]
            swipableCells[emptySlotIndexPair.i][index] = empty
            emptySlotIndexPair.j += 1
            
            // Swap the positions of the cells
            let emptyPosition = empty.position
            empty.position = cell.position
            cell.slide(to: emptyPosition, completion: completion)
            
            hasPerformedSwipe = true
        case .down:
            let index = emptySlotIndexPair.i - 1
            guard index >= 0 else { return false }
            
            // Swap the model positions of the cells
            let empty = swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j]
            let cell = swipableCells[index][emptySlotIndexPair.j]
            
            swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j] = swipableCells[index][emptySlotIndexPair.j]
            swipableCells[index][emptySlotIndexPair.j] = empty
            emptySlotIndexPair.i -= 1
            
            // Swap the positions of the cells
            let emptyPosition = empty.position
            empty.position = cell.position
            cell.slide(to: emptyPosition, completion: completion)
            
            hasPerformedSwipe = true

        case .none: () // No swipe action is required
        }
        
        return hasPerformedSwipe
    }
    
    /// Evaluates whether the puzzle is solved or not
    /// Time complexity is O(n - 1)
    func isCorrect() -> Bool {
        var i = 0, j = 0
        
        for _ in 1..<swipableCells.count {
            let previous = i - 1
            let previousCell = swipableCells[previous][j - 1]
            let currentCell = swipableCells[previous][j]
            
            guard previousCell.number < currentCell.number else {
                return false
            }
            
            if j == indexBoundary - 1 {
                j = 0
                i += 1
            } else { j += 1 }
        }
        
        return true
    }
}

private extension GameBoard {
    
    func testHorizontalSwipe(for operation: (Int, Int) -> Void) {
        
    }
    
    func testVerticalSwipe(fopr operation: (Int, Int) -> Void) {
        
    }
}
