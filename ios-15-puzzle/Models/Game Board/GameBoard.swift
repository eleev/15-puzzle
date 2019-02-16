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
    
    private var generator: NumberGeneratorType
    private weak var scene: SKScene?
    
    // The square root is needed in a number of calculations, in order to avoid expensive calculation that may lead to O(n * 2) computation complexity. Particularly, the `indexBoundary` property is used in conversion of nodes from one dimensional form to two dimensioal array. Working with a two dimensional array grethly simplifies the cell swiping operations
    private let indexBoundary = Int(sqrt(Double(Constants.numberOfNodes + 1)))
    
    /// Empty slot index pair is a tuple that holds the current, two dimensional location for the empty slot. All the futher calculations, for swiping cells, are based on the latest location of the empty cell (see `resolveSwipe` method)
    private var emptySlotIndexPair = (i: 0, j: 0)
 
    // MARK: - Static properties
    
    private static let SLOT_NAME = "Slot Node"
    
    // MARK: - Initializes
    
    init(scene: SKScene, numberGenerator: NumberGeneratorType) throws {
        self.generator = numberGenerator
        self.scene = scene
        
        nodeSlots = scene.children.filter { $0.name?.contains(GameBoard.SLOT_NAME) ?? false }
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
            for (j, node) in row.enumerated() where node.name == name {
                return (i, j, node)
            }
        }
        return nil
    }
    
    /// Resolves all the movement for O(n) time by applying swap function for the nodes
    func resolveSwipe(for direction: Direction, completion: @escaping () -> Void) -> Bool {
        var hasPerformedSwipe = false
        let shift = 1
        
        switch direction {
        case .right:
            let index = emptySlotIndexPair.j - shift
            guard index >= 0 else { return false }
            
            performHorizontalSwipe(for: index, by: .substracting(shift), completion: completion)
            hasPerformedSwipe = true
        case .up:
            let index = emptySlotIndexPair.i + shift
            guard index < indexBoundary else { return false }

            performVerticalSwipe(fop: index, by: .adding(shift), completion: completion)
            hasPerformedSwipe = true
        case .left:
            let index = emptySlotIndexPair.j + shift
            guard index < indexBoundary else { return false }
            
            performHorizontalSwipe(for: index, by: .adding(shift), completion: completion)
            hasPerformedSwipe = true
        case .down:
            let index = emptySlotIndexPair.i - shift
            guard index >= 0 else { return false }

            performVerticalSwipe(fop: index, by: .substracting(shift), completion: completion)
            hasPerformedSwipe = true
        case .none: () // No swipe action is required
        }
        
        return hasPerformedSwipe
    }
    
    /// Evaluates whether the puzzle is solved or not
    /// Time complexity in works case is O(n - 1) (when puzzle is solved), otherwise, the amortized time complexity is around O(log n)
    func isCorrect() -> Bool {
        let incrementor = 1
        var i = 0, j = incrementor
        let decrementedIndexBoundary = indexBoundary - incrementor
        
        for _ in incrementor..<swipableCells.count {
            let previous = i
            let previousCell = swipableCells[previous][j - incrementor]
            let currentCell = swipableCells[previous][j]
            
            // If all the comparisons were corrent and we reached the end of the array, and the last element is the empty cell, then the puzzle is solved
            if previous == decrementedIndexBoundary, j == decrementedIndexBoundary, currentCell.number == 0 {
                return true
            }
     
            // Make sure that the previous element is less than the current one, that makes the order ascending, which eventually leads to the corrent solution, if all the elements are ordered in this manner
            // Another check is if the previous cell contains the empty node, which may never lead to the resolution of the puzzle, so we exit early if the test fails
            guard previousCell.number < currentCell.number, previousCell.number != 0 else {
                return false
            }
            
            if j == decrementedIndexBoundary {
                j = incrementor
                i += incrementor
            } else { j += incrementor }
        }
        return true
    }
}

// MARK: - Swiping functionality
private extension GameBoard {
    
    func performVerticalSwipe(fop index: Int, by operation: SwipeOperation, completion: @escaping () -> Void) {

        let empty = swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j]
        let cell = swipableCells[index][emptySlotIndexPair.j]
        
        swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j] = swipableCells[index][emptySlotIndexPair.j]
        swipableCells[index][emptySlotIndexPair.j] = empty
        
        let operationClosure = operation.getOperation()
        emptySlotIndexPair.i = operationClosure(emptySlotIndexPair.i, operation.getValue())
        
        let emptyPosition = empty.position
        empty.position = cell.position
        cell.slide(to: emptyPosition, completion: completion)
    }
    
    func performHorizontalSwipe(for index: Int, by operation: SwipeOperation, completion: @escaping () -> Void) {

        let empty = swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j]
        let cell = swipableCells[emptySlotIndexPair.i][index]
        
        swipableCells[emptySlotIndexPair.i][emptySlotIndexPair.j] = swipableCells[emptySlotIndexPair.i][index]
        swipableCells[emptySlotIndexPair.i][index] = empty
        
        let operationClosure = operation.getOperation()
        emptySlotIndexPair.j = operationClosure(emptySlotIndexPair.j, operation.getValue())
        
        let emptyPosition = empty.position
        empty.position = cell.position
        cell.slide(to: emptyPosition, completion: completion)
    }
    
}

// MARK: - Shuffle functionality
extension GameBoard {
    func shuffle(iterations: UInt8) {
        if iterations == 0 { return }
        let randomDirection = Direction.random()
        
        let result = resolveSwipe(for: randomDirection) { [weak self] in
            // Make a resursive call as soon as the shuffle operation was completed, and make sure that the iterations count is decremented
            self?.shuffle(iterations: iterations - 1)
        }
        if !result { shuffle(iterations: iterations - 1) }
    }
    
    func shuffle(using directions: [Direction],
                 iteration: @escaping () -> Void = { /* default, empty closure */ },
                 completion: @escaping () -> Void) {
        if directions.isEmpty {
            completion()
            return
        }
        
        var localDirections = directions
        let direction = localDirections.removeLast()
        
        let result = resolveSwipe(for: direction) { [weak self] in
            iteration()
            self?.shuffle(using: localDirections, iteration: iteration,completion: completion)
        }
        if !result { shuffle(using: localDirections, iteration: iteration, completion: completion) }
    }
}
