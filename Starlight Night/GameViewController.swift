//
//  GameViewController.swift
//  Starlight Night
//
//  Created by Alexey on 1/26/20.
//  Copyright © 2020 it-Business-Partner. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import WebKit

class GameViewController: UIViewController, WKUIDelegate {

    var target = 1
    @IBOutlet weak var webView: UIWebView!
   // @IBOutlet weak var buttonStart: UIButton!

   @IBOutlet weak var backButton: UIButton!

    override func viewDidLoad() {
       backButton.isHidden = true
        webView.isHidden = true
        if target == 1 {

       // buttonStart.titleLabel!.text = "Restart"
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
        } else {
            backButton.isHidden = false
            webView.isHidden = false
            let myURL = URL(string:"https://fresh21.casino")
            let myRequest = URLRequest(url: myURL!)
            webView.loadRequest(myRequest)
            super.viewDidLoad()
        }
    }

    @IBAction func backAction(_ sender: Any) {
        webView.goBack()
    }
    @IBAction func pr1(_ sender: Any) {
        print("1")
    }
    @IBAction func pr2(_ sender: Any) {
        print("2")
    }
    @IBAction func pr3(_ sender: Any) {
        print("3")
    }
    @IBAction func pr4(_ sender: Any) {
        print("4")
    }
    @IBAction func pr5(_ sender: Any) {
        print("5")
    }



//    override var shouldAutorotate: Bool {
//        return true
//    }

//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
//    }

//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//}
}
