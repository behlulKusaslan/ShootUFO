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
    
    var possibleAliens = ["alien", "alien2", "alien3"]
    var score: Int = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var gameTimer: Timer!
    var WIDTH: CGFloat!
    var HEIGHT: CGFloat!
    
    override func didMove(to view: SKView) {
        
        WIDTH = self.frame.size.width
        HEIGHT = self.frame.size.height
        
        starField = SKEmitterNode(fileNamed: "Starfield")
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
        
        gameTimer = Timer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
    }
    
    @objc func addAlien() {
        guard let shuffeldArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as? [String] else { return }
        possibleAliens = shuffeldArray
        
        let alien = SKSpriteNode(imageNamed: possibleAliens[0])
        let randomAlienPosition = GKRandomDistribution(lowestValue: Int(-WIDTH/2), highestValue: Int(WIDTH/2))
        let positionX = CGFloat(randomAlienPosition.nextInt())
        
        alien.position = CGPoint(x: positionX, y: HEIGHT/2 - alien.size.height)
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
