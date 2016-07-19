//
//  ArcheryScene.swift
//  SpriteKitDemo
//
//  Created by JHJG on 2016. 7. 18..
//  Copyright © 2016년 KangJungu. All rights reserved.
//

import UIKit
import SpriteKit

class ArcheryScene: SKScene {
    var score = 0
    var ballCount = 20
    
    override func didMoveToView(view: SKView) {
        self.initArcherScene()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let archerNode = self.childNodeWithName("archerNode"){
            let animate = SKAction(named: "animateArcher")
            //새로운 SKAction 객체를 생성하면서 실행할 코드 블록을 지정한다.
            let shootArrow = SKAction.runBlock({
                print("Shoot")
                //createArrowNode 메서드를 호출하고 화면에 새로운 노드를 추가한 다음에 화면의 x축으로 60.0의 힘을 적용한다.
                let arrowNode = self.createArrowNode()
                self.addChild(arrowNode)
                arrowNode.physicsBody?.applyImpulse(CGVectorMake(60.0, 0))
            })
            let sequence = SKAction.sequence([animate!,shootArrow])
            //SKAction 시퀀스는 이전에 생성한 애니메이션 액션과 새로운 런 블록 액션을 포함하도록 생성된다.
            archerNode.runAction(sequence)
        }
    }
    
    //새로운 SKSpriteNode 객체를 생성하고, 궁수 스프라이트 노드의 오른쪽에 위치시키며, 이름을 arrowNode라고 할당한다. 그런다음 물리몸체가 그노드에 할당되며 노드의 경계로 노드 자신의 크기를 이용하고 충돌 감지를 활성화 한다. 마지막으로 노드를 반환한다.

    func createArrowNode() -> SKSpriteNode{
        let archerNode = self.childNodeWithName("archerNode")
        let archerPosition = archerNode?.position
        let archerWidth = archerNode?.frame.size.width
        
        let arrow = SKSpriteNode(imageNamed: "ArrowTexture.png")
        arrow.position = CGPointMake(archerPosition!.x + archerWidth!, archerPosition!.y)
        arrow.name = "arrowNode"
        
        arrow.physicsBody = SKPhysicsBody(rectangleOfSize: arrow.frame.size)
        
        arrow.physicsBody?.usesPreciseCollisionDetection = true
        
        return arrow
    }
    

    func createBallNode(){
        //공 텍스처를 이용하여 노드생성
        let ball = SKSpriteNode(imageNamed: "BallTexture.png")
        //랜덤한 x축에 위치시키고
        ball.position = CGPointMake(randomBetween(0,high: self.size.width-200), self.size.height-50)
        
        //노드에 이름과 공이미지의 반경보다 약간 작은 물리 몸체를 할당한다.
        ball.name = "ballNode"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: (ball.size.width/2))
        //정밀 충돌 감지가 활성화되며
        ball.physicsBody?.usesPreciseCollisionDetection = true
        //공 노드는 화면에 추가된다.
        self.addChild(ball)
    }
    
    func randomBetween(low: CGFloat, high: CGFloat) -> CGFloat{
        let lowInt = UInt32(low)
        let highInt = UInt32(high) - UInt32(low)
        let result = arc4random_uniform(highInt) + UInt32(lowInt)
        return CGFloat(result)
    }
    
    func initArcherScene(){
        let releaseBalls = SKAction.sequence([SKAction.runBlock({ 
            self.createBallNode()}),
            SKAction.waitForDuration(1)])
        self.runAction(SKAction.repeatAction(releaseBalls, count: ballCount))
    }

}
