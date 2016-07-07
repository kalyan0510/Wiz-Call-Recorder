/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Foundation
import SceneKit

class Atoms {
  class func carbonAtom() -> SCNGeometry {
    let carbonAtom = SCNTube(innerRadius: 1.5, outerRadius: 1.7, height: 0.2)
    carbonAtom.firstMaterial!.diffuse.contents = UIColor(red: 95/255, green: 248/255, blue: 251/255, alpha: 1)

    carbonAtom.firstMaterial!.specular.contents = UIColor(red: 95/255, green: 248/255, blue: 251/255, alpha: 1)

    return carbonAtom
  }
  
  class func hydrogenAtom() -> SCNGeometry {
    let hydrogenAtom = SCNSphere(radius: 1.20)
    hydrogenAtom.firstMaterial!.diffuse.contents = UIColor.lightGrayColor()
    hydrogenAtom.firstMaterial!.specular.contents = UIColor.whiteColor()
    return hydrogenAtom
  }
  
  class func oxygenAtom() -> SCNGeometry {
    let oxygenAtom = SCNSphere(radius: 1.52)
    oxygenAtom.firstMaterial!.diffuse.contents = UIColor.redColor()
    oxygenAtom.firstMaterial!.specular.contents = UIColor.whiteColor()
    return oxygenAtom
  }
  
  class func fluorineAtom() -> SCNGeometry {
    let fluorineAtom = SCNSphere(radius: 1.47)
    fluorineAtom.firstMaterial!.diffuse.contents = UIColor.yellowColor()
    fluorineAtom.firstMaterial!.specular.contents = UIColor.whiteColor()
    return fluorineAtom
  }

    
  
  class func allAtoms() -> SCNNode {
    let atomsNode = SCNNode()
    
    let carbonNode = SCNNode(geometry: carbonAtom())
    carbonNode.name = "carbon"
    atomsNode.addChildNode(carbonNode)
    return atomsNode
  }
    
    class func textBox() -> SCNText {
        let box = SCNText(string: "0:00", extrusionDepth: 0.01)
        box.firstMaterial!.diffuse.contents = UIColor.whiteColor()
        box.firstMaterial!.specular.contents = UIColor.whiteColor()
        return box
    }
    class func squareBoxEmitter() -> SCNGeometry {
        let box = SCNBox(width: 10 , height: 10, length: 10, chamferRadius: 0.1)
        return box
    }
    class func squareBox() -> SCNGeometry {
        let box = SCNBox(width: 0.2, height: 5, length: 0.1, chamferRadius: 0.1)
        box.firstMaterial!.diffuse.contents = UIColor(red: 95/255, green: 248/255, blue: 251/255, alpha: 1)
        box.firstMaterial!.specular.contents = UIColor.whiteColor()
        return box
    }
    class func squareBoxN() -> SCNGeometry {
        let box = SCNBox(width: 0.2, height: 5, length: 0.1, chamferRadius: 0.1)
        box.firstMaterial!.diffuse.contents = UIColor(red: 43/255, green: 116/255, blue: 117/255, alpha: 1)
        box.firstMaterial!.specular.contents = UIColor.whiteColor()
        return box
    }
    
    class func bar() -> SCNNode {
        let barnode = SCNNode()
        let  hydrogenNode = SCNNode(geometry: squareBox())
        hydrogenNode.name = "bar"
        barnode.addChildNode(hydrogenNode)
        
        return barnode

    }
    class func textNode() -> SCNNode {
        let barnode = SCNNode()
        let  hydrogenNode = SCNNode(geometry: textBox())
        
        
        barnode.addChildNode(hydrogenNode)
        
        hydrogenNode.scale = SCNVector3Make(0.055 ,0.055, 0.055)
        return barnode
        
    }
    class func bars() -> SCNNode {
        let barnode = SCNNode()
        
        
        //hydrogenNode.name = "bar"
        
        for i in 1...18 {
            let hydrogenNode = SCNNode(geometry: squareBox())
            hydrogenNode.position = SCNVector3Make(-(Float(i+4)/(2.2)), 0, 0)
            barnode.addChildNode(hydrogenNode)
        }
        
        for i in 1...18 {
            let hydrogenNode = SCNNode(geometry: squareBox())
            hydrogenNode.position = SCNVector3Make((Float(i+4)/(2.2)), 0, 0)
            barnode.addChildNode(hydrogenNode)
        }
        
        return barnode
        
    }
    class func barsN() -> SCNNode {
        let barnode = SCNNode()
        
        
        //hydrogenNode.name = "bar"
        
        for i in 1...18 {
            let hydrogenNode = SCNNode(geometry: squareBoxN())
            hydrogenNode.position = SCNVector3Make(-(Float(i+4)/(2.2)), 0, 0)
            barnode.addChildNode(hydrogenNode)
        }
        
        for i in 1...18 {
            let hydrogenNode = SCNNode(geometry: squareBoxN())
            hydrogenNode.position = SCNVector3Make((Float(i+4)/(2.2)), 0, 0)
            barnode.addChildNode(hydrogenNode)
        }
        
        return barnode
        
    }

    
    class func incHto(node: SCNNode,float : Float) {
        SCNTransaction.begin()
        SCNTransaction.setAnimationDuration(0.1)
        let x = node.geometry as! SCNBox
        x.height = CGFloat(float)
        node.pivot = SCNMatrix4MakeTranslation(0, -(float/2), 0)
        
        SCNTransaction.commit()
    }
    class func incHtoN(node: SCNNode,float : Float) {
        SCNTransaction.begin()
        SCNTransaction.setAnimationDuration(0.1)
        let x = node.geometry as! SCNBox
        x.height = CGFloat(float)
        node.pivot = SCNMatrix4MakeTranslation(0, (float/2), 0)
        
        SCNTransaction.commit()
    }
}
