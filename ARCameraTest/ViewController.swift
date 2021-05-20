//
//  ViewController.swift
//  ARCameraTest
//
//  Created by 福島大稀 on 2021/05/20.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var arSceanView: ARSCNView!
    @IBAction func handleTap(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        arSceanView.session = ARSession()
        
        arSceanView.showsStatistics = true
        arSceanView.debugOptions = ARSCNDebugOptions.showFeaturePoints
    }

    override func viewDidAppear(_ animated: Bool) {
        let configuration = ARWorldTrackingConfiguration()
        arSceanView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        arSceanView.session.pause()
    }

}

