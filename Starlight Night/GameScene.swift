//
//  GameScene.swift
//  Starlight Night
//
//  Created by Alexey on 1/26/20.
//  Copyright © 2020 it-Business-Partner. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var player: SKSpriteNode!
    private var bacgraund: SKEmitterNode!
    private var bacgraundImage: SKSpriteNode!
    private var coinImage: SKSpriteNode!
    private var scoreLable: SKLabelNode!
    private var score:Int = 0 {
        didSet {
            scoreLable.text = "  : \(score)"
        }
    }
    private var timeLable: SKLabelNode!
    private var gameTime:Float = 0{
        didSet{
            timeLable.text = "Время : \(Int(gameTime))"
        }
    }
    private var gameTimer:Timer!

    private var alians = ["alian","alian2","alian3"]
    private let alianCategory:UInt32 = 0x1 << 1
    private let bulletCategory:UInt32 = 0x1 << 0
    private let aninmDuration:TimeInterval = 9
    private let timerAlian:TimeInterval = 1

    private let motionManager = CMMotionManager()
    private var xAccselerate:CGFloat = 0



    override func didMove(to view: SKView) {
        bacgraund = SKEmitterNode(fileNamed: "Stars")
        bacgraund.position = CGPoint(x: 0, y: 0)
       // bacgraund.(to: CGSize(width: 1472, height: 1472))
        bacgraund.zPosition = -1
        self.addChild(bacgraund)

        bacgraundImage = SKSpriteNode(imageNamed: "space")
        bacgraundImage.position = CGPoint(x: 0,y: 0)
        bacgraundImage.size = CGSize(width: 1472, height: 1472)
        bacgraundImage.zPosition = -2
        self.addChild(bacgraundImage)

        player = SKSpriteNode(imageNamed: "starship")
        player.position = CGPoint(x: 0, y: 250 - (self.frame.size.height/2))
        if #available(iOS 10.0, *) {
            player.scale(to: CGSize(width: 100, height: 100))
        } else {
            // Fallback on earlier versions
        }
        player.zPosition = 5
        self.addChild(player)

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self


        scoreLable = SKLabelNode(text: "  : 0")
        scoreLable.fontName = "AmericanTypewriter-Bold"
        scoreLable.fontSize = 36
        scoreLable.color = UIColor.white
        scoreLable.position = CGPoint(x: self.frame.size.width/2 - 100, y: self.frame.size.height/2 - 100)
        scoreLable.zPosition = 1
        self.addChild(scoreLable)
        
        coinImage = SKSpriteNode(imageNamed: "coin")
        coinImage.position = CGPoint(x: self.frame.size.width/2 - 150, y: self.frame.size.height/2 - 90)
        coinImage.size = CGSize(width: 50, height: 50)
        self.addChild(coinImage)
        timeLable = SKLabelNode(text: "Время:  0")
        timeLable.fontName = "AmericanTypewriter-Bold"
        timeLable.fontSize = 36
        timeLable.color = UIColor.white
        timeLable.position = CGPoint(x: -self.frame.size.width/2 + 150, y: self.frame.size.height/2 - 100)
        timeLable.zPosition = 1
        self.addChild(timeLable)

        gameTimer = Timer.scheduledTimer(timeInterval: timerAlian, target: self, selector: #selector(addAlian), userInfo: nil, repeats: true)

        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data: CMAccelerometerData?, error: Error?) in
            if let accelerometrData =  data{
                let acceleration = accelerometrData.acceleration
                self.xAccselerate = CGFloat(acceleration.x) * 0.75 + self.xAccselerate * 0.25
            }
        }
    }

    override func didSimulatePhysics() {
        player.position.x += xAccselerate * 50

        if player.position.x < -self.frame.size.width/2 {
            player.position.x = self.frame.size.width/2
        }
        if player.position.x > self.frame.size.width/2{
            player.position.x = -self.frame.size.width/2
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        var fierstBody:SKPhysicsBody //alian
        var secondBody:SKPhysicsBody //bullet

        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask{
            fierstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            fierstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if((fierstBody.categoryBitMask & alianCategory) != 0 && (secondBody.categoryBitMask & bulletCategory) != 0){
            collisionElements(bulletNode: secondBody.node as! SKSpriteNode, alianNode: fierstBody.node as! SKSpriteNode)
        }
    }

    func collisionElements(bulletNode:SKSpriteNode,alianNode:SKSpriteNode){
        let explosion = SKEmitterNode(fileNamed: "Fire")
        explosion!.position = alianNode.position
        explosion!.setScale(alianNode.xScale*2)

        self.addChild(explosion!)

        bulletNode.removeFromParent()
        alianNode.removeFromParent()

        self.run(SKAction.wait(forDuration: 2)){
            explosion?.removeFromParent()
        }

        score += 5
    }


    @objc private func addAlian() {
        self.gameTime += Float(timerAlian)
        alians = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: alians) as! [String]

        let alian = SKSpriteNode(imageNamed: alians[0])
        let randomPos = GKRandomDistribution(lowestValue: Int(40-self.frame.size.width/2), highestValue: Int(self.frame.size.width/2-40))
        let pos = CGFloat(randomPos.nextInt())
        if #available(iOS 10.0, *) {
            alian.scale(to: CGSize(width: 80, height: 80))
        } else {
            // Fallback on earlier versions
        }
        alian.position = CGPoint(x: pos, y: self.frame.size.height+100)

        alian.physicsBody = SKPhysicsBody(rectangleOf: alian.size)
        alian.physicsBody?.isDynamic = true
        alian.physicsBody?.categoryBitMask = alianCategory
        alian.physicsBody?.contactTestBitMask =  bulletCategory
        alian.physicsBody?.collisionBitMask = 0
        alian.zPosition = 0

        self.addChild(alian)


        var action = [SKAction]()
        action.append(SKAction.move(to: CGPoint(x: pos, y: -(self.frame.size.height+alian.size.height)), duration: aninmDuration))
        action.append(SKAction.removeFromParent())

        alian.run(SKAction.sequence(action))
    }

    private func fireBullet(){
        let bullet = SKSpriteNode(imageNamed: "torpedo")
        if #available(iOS 10.0, *) {
            bullet.scale(to: CGSize(width: 60, height: 60))
        } else {
            // Fallback on earlier versions
        }
        bullet.position = player.position
        bullet.position.y += 10

        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.height)
        bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.categoryBitMask = bulletCategory
        bullet.physicsBody?.contactTestBitMask =  alianCategory
        bullet.physicsBody?.collisionBitMask = 0
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        bullet.zPosition = 0

        self.addChild(bullet)

        var action = [SKAction]()
        action.append(SKAction.move(to: CGPoint(x: bullet.position.x, y: self.frame.size.height+bullet.size.height), duration: 0.30))
        action.append(SKAction.removeFromParent())

        bullet.run(SKAction.sequence(action))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireBullet()
    }

    override func update(_ currentTime: TimeInterval) {
    }
}
