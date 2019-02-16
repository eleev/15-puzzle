//
//  Direction+SwipeGestureInitializer.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 16/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

#if os(iOS) || os(tvOS)

import Foundation
import class UIKit.UISwipeGestureRecognizer

extension Direction {
    init(direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .right:
            self = .right
        case .left:
            self = .left
        case .up:
            self = .up
        case .down:
            self = .down
        default:
            self = .none
        }
    }
}
#endif
