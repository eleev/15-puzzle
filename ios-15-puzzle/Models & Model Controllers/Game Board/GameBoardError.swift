//
//  GameBoardError.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 15/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation

enum GameBoardError: Error {
    case invalidNumberOf(cells: UInt, message: String)
}
