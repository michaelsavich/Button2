import SpriteKit

public protocol PointConsumer {
    func consumePoint(_ viewPoint: CGPoint) -> Bool //returns true iff the point triggered the control
}

public class Button2: SKNode {
    
    public var block: (() -> Void)?
    
    public var labelNode: SKLabelNode?   {
        didSet{ updateLayout() }
    }
    public var platterNode: SKShapeNode = SKShapeNode(rect: CGRect(x:0,y:0,width:50,height:100)) {
        didSet{ self.updateLayout() }
    }
    
    private func updateLayout() {
        self.removeAllChildren()
        self.addChild(self.platterNode)
        if let label = self.labelNode {
            self.addChild(label)
        }
    }
}

#if os(iOS) || os(macOS) || os(tvOS)
extension Button2: PointConsumer {
    open func consumePoint(_ viewPoint: CGPoint) -> Bool {
        guard let scene = self.scene else { return false }
        
        let scenePoint = scene.convertPoint(fromView: viewPoint)
        if scene.nodes(at: scenePoint).contains(self.platterNode) {
            if let b = self.block { b() }
            return true
        }
        else {
            return false
        }
    }
}
#elseif os(watchOS)
extension Button2: PointConsumer {
    open func performTap() {
        self.consumePoint(CGPoint(x:0,y:0))
    }
    private func consumePoint(_ viewPoint: CGPoint) -> Bool {
        if let b = self.block { b() }
        return true
    }
}
/*   
     Unfortunately, watchOS does not seem to allow converting a point from the view space to the scene space.
     As a concession, any CGPoint will trigger any Button2 on the watch.
     It is reccomended to limit each SKScene to containing only one Button2.
*/
#endif
