//
//  ViewController.swift
//  Face
//
//  Created by 西岡亮太 on 2020/06/15.
//  Copyright © 2020 西岡亮太. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var previewSceanView: SCNView!
        private var airPlaneNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        previewSceanView.scene = SCNScene(named: "art.scnassets/ship.scn")
        previewSceanView.alpha = 0.8
        previewSceanView.isPlaying = true
        airPlaneNode = previewSceanView.scene?.rootNode.childNode(withName: "ship", recursively: true)!
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let ship = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
      let defaultConfiguration: ARFaceTrackingConfiguration = {
        let configuration = ARFaceTrackingConfiguration()
        //configuration.frameSemantics = .personSegmentationWithDepth
        return configuration
        }()
        

        // Run the view's session
        sceneView.session.run(defaultConfiguration)
    }
    


    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        

        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard  let anchor = anchor as? ARFaceAnchor else {
            return
        }

        
        if let tongueOut = anchor.blendShapes[.tongueOut] as? Float{
            if tongueOut > 0.5{
            print("tongueOut")
                
                let action = SCNAction.rotateBy(x: 0, y: 0, z: .pi/2, duration: 10)
                airPlaneNode.runAction(action)
            }
        }
        
        if let eyeLookInLeft = anchor.blendShapes[.eyeLookInLeft] as? Float{
            if eyeLookInLeft > 0.5{
            print("eyeLookInLeft")
                
                let action = SCNAction.rotateBy(x: .pi/2, y: 0, z: 0, duration: 10)
                airPlaneNode.runAction(action)
            }
        }
        
        if let eyeLookOutLeft = anchor.blendShapes[.eyeLookOutLeft] as? Float{
            if eyeLookOutLeft > 0.5{
            print("eyeLookOutLeft")
                let action = SCNAction.rotateBy(x: -.pi/2, y: 0, z: 0, duration: 10)
                airPlaneNode.runAction(action)
            }
        }
    }
   
        func session(_ session: ARSession, didFailWithError error: Error) {
            // Present an error message to the user
            
        }
        
        func sessionWasInterrupted(_ session: ARSession) {
            // Inform the user that the session has been interrupted, for example, by presenting an overlay
            
        }
        
        func sessionInterruptionEnded(_ session: ARSession) {
            // Reset tracking and/or remove existing anchors if consistent tracking is required
            
        }
    
}
