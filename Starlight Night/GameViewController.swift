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
import FBSDKCoreKit
import WebKit

class GameViewController: UIViewController, WKUIDelegate {

    var target = 1
    @IBOutlet weak var webView: UIWebView!

   @IBOutlet weak var backButton: UIButton!

    override func viewDidLoad() {
       backButton.isHidden = true
        webView.isHidden = true
        if target == 1 {
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
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
}
