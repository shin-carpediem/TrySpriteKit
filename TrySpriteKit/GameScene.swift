import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        label = childNode(withName: "//helloLabel") as? SKLabelNode
        if let label {
            label.alpha = .zero
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (size.width + size.height) * 0.05
        spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos: CGPoint) {
        if let node = spinnyNode?.copy() as! SKShapeNode? {
            node.position = pos
            node.strokeColor = SKColor.green
            addChild(node)
        }
    }
    
    func touchMoved(toPoint pos: CGPoint) {
        if let node = spinnyNode?.copy() as! SKShapeNode? {
            node.position = pos
            node.strokeColor = SKColor.blue
            addChild(node)
        }
    }
    
    func touchUp(atPoint pos: CGPoint) {
        if let node = spinnyNode?.copy() as! SKShapeNode? {
            node.position = pos
            node.strokeColor = SKColor.red
            addChild(node)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for touch in touches { touchDown(atPoint: touch.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { touchMoved(toPoint: touch.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { touchUp(atPoint: touch.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { touchUp(atPoint: touch.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
