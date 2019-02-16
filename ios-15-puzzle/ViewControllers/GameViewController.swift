//
//  GameViewController.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 14/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            var sceneName: String
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                sceneName = Constants.GameSceneType.pad.rawValue
            } else {
                sceneName = Constants.GameSceneType.phone.rawValue
            }
            
            if let scene = SKScene(fileNamed: sceneName) {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
