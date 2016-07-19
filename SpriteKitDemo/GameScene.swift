//
//  GameScene.swift
//  SpriteKitDemo
//
//  Created by JHJG on 2016. 7. 18..
//  Copyright (c) 2016년 KangJungu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //노드에 대한 참조체를 메서드 내에서 얻는다.
        let welcomeNode = childNodeWithName("welcomNode")
        
        if welcomeNode != nil {
            //노드가 뷰에서 1초동안 사라지도록 설정된 새로운 SKAction 인스턴스를 생성
            let fadeAway = SKAction.fadeOutWithDuration(1.0)
            
            //위에서 생성한 액션을 실행.
            welcomeNode?.runAction(fadeAway, completion: {
                //액션이 완료될 때 실행될 완료 블록도 지정된다. ArcheryScene클래스의 인스턴스와 적절하게 설정된 SKTransition 객체를 생선한다. 그리고서 새로운 화면에 대한 전환이 시작된다.
                let doors = SKTransition.doorwayWithDuration(1.0)
                let archeryScene = ArcheryScene(fileNamed: "ArcheryScene")
                self.view?.presentScene(archeryScene!,transition:doors)
            })
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
