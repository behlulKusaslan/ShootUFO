//
//  GameScene.swift
//  ShootUFO
//
//  Created by behlul on 27.12.2017.
//  Copyright © 2017 behlul. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starField: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var score: Int = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        
        let WIDTH = self.frame.size.width
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
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: -WIDTH / 2 + scoreLabel.frame.size.width, y: HEIGHT / 2 - 60)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 42
        scoreLabel.fontColor = UIColor.white
        self.addChild(scoreLabel)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
