//
//  ViewController.swift
//  ARCameraTest
//
//  Created by 福島大稀 on 2021/05/20.
//

import UIKit
import ARKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var isRotationInitialized = false
    var northRotate: SCNVector4?
    
    
    

    @IBOutlet weak var arSceanView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        arSceanView.session = ARSession()
        
        arSceanView.showsStatistics = true
        arSceanView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }

    override func viewDidAppear(_ animated: Bool) {
        let configuration = ARWorldTrackingConfiguration()
        arSceanView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        arSceanView.session.pause()
    }
    
    @IBAction func handleTap(_ sender: Any) {
        guard let camera = arSceanView.pointOfView else {
            return
        }
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let boxNode = SCNNode(geometry: box)
        
        let relativePosition = SCNVector3(x: 0, y: 0, z: -1)
        boxNode.position = camera.convertPosition(relativePosition, to: nil)
        
        arSceanView.scene.rootNode.addChildNode(boxNode)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading:CLHeading) {
        let nowHeading = newHeading.magneticHeading
        
        if !isRotationInitialized {
            northRotate = SCNVector4(0,1,0,(nowHeading/180)*Double.pi)
            isRotationInitialized = true
        }
        
    }

}

