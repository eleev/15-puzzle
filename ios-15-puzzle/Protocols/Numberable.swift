//
//  Numberable.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 15/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation

protocol Numberable: class {
    var number: UInt { get }
}

extension Numberable {
    func getStringRepresentation() -> String {
        return "\(number)"
    }
}
