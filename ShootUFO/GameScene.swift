//
//  GameScene.swift
//  ShootUFO
//
//  Created by behlul on 27.12.2017.
//  Copyright © 2017 behlul. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var starField: SKEmitterNode!
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
//        let WIDTH = self.frame.size.width
        let HEIGHT = self.frame.size.height
        
        starField = SKEmitterNode(fileNamed: "Starfield")
        // TODO: find actual sizes for specific phone later
        starField.position = CGPoint(x: 0.0, y: HEIGHT)
        starField.advanceSimulationTime(10)
        starField.zPosition = -1
        self.addChild(starField)
        
        player = SKSpriteNode(imageNamed: "shuttle")
        player.position = CGPoint(x: 0, y: -HEIGHT / 2 + 100)
        self.addChild(player)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
