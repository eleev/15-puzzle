//
//  FeedbackGenerator.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 16/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import UIKit

struct FeedbackGenerator {
    
    // MARK: - Enum types
    
    enum Style {
        case heavy
        case medium
        case light
    }
    
    // MARK: - Properties
    
    static private var generatorHeavy: UIImpactFeedbackGenerator = {
        let generator = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
        generator.prepare()
        return generator
    }()
    
    static private var generatorMedium: UIImpactFeedbackGenerator = {
        let generator = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.medium)
        generator.prepare()
        return generator
    }()
    
    static private var generatorLight: UIImpactFeedbackGenerator = {
        let generator = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.light)
        generator.prepare()
        return generator
    }()
    
    // MARK: - Methods
    
    static func generate(for style: Style) {
        switch style {
        case .heavy:
            FeedbackGenerator.generatorHeavy.impactOccurred()
        case .medium:
            FeedbackGenerator.generatorMedium.impactOccurred()
        case .light:
            FeedbackGenerator.generatorLight.impactOccurred()
        }
    }
}
