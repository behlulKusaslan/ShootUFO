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
    let alienCategory: UInt32 = 0x01 << 1
    let photonTorpedoCategory: UInt32 = 0x01 << 0
    
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
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
    }
    
    @objc func addAlien() {
        guard let shuffeldArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as? [String] else { return }
        possibleAliens = shuffeldArray
        
        let alien = SKSpriteNode(imageNamed: possibleAliens[0])
        let randomAlienPosition = GKRandomDistribution(lowestValue: Int(-WIDTH/2)+16, highestValue: Int(WIDTH/2)-16)
        let positionX = CGFloat(randomAlienPosition.nextInt())
        
        alien.position = CGPoint(x: positionX, y: HEIGHT/2)
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        
        alien.physicsBody?.categoryBitMask = alienCategory
        alien.physicsBody?.contactTestBitMask = photonTorpedoCategory
        alien.physicsBody?.collisionBitMask = 0
        
        self.addChild(alien)
        
        let animationDuration: TimeInterval = 6
        var actionArray = [SKAction]()
        let maxPositionY = -HEIGHT/2 - alien.size.height
        
        actionArray.append(SKAction.move(to: CGPoint(x: positionX, y: maxPositionY), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        alien.run(SKAction.sequence(actionArray))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireTorpedo()
    }
    
    func fireTorpedo() {
        self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
        
        let torpedoNode = SKSpriteNode(imageNamed: "torpedo")
        torpedoNode.position = player.position
        torpedoNode.position.y += 5
        
        torpedoNode.physicsBody = SKPhysicsBody(circleOfRadius: torpedoNode.size.width/2)
        torpedoNode.physicsBody?.isDynamic = true
        torpedoNode.physicsBody?.categoryBitMask = photonTorpedoCategory
        torpedoNode.physicsBody?.contactTestBitMask = alienCategory
        torpedoNode.physicsBody?.collisionBitMask = 0
        torpedoNode.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(torpedoNode)
        
        let animationDuration: TimeInterval = 0.4
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: HEIGHT/2 + 10), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        torpedoNode.run(SKAction.sequence(actionArray))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
