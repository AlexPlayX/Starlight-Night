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


    @IBOutlet weak var webView: WKWebView!

    @IBOutlet weak var backMenu: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButtonTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        let targeter = UserDefaults.standard.integer(forKey: "target")
       backButton.isHidden = true
        webView.isHidden = true
        backMenu.isHidden = true
        if targeter != 1 {
            backMenu.isHidden = false
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
        } else {
            backButton.isHidden = false
            backMenu.isHidden = false
            webView.isHidden = false
            let myURL = URL(string:"https://fresh21.casino")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            super.viewDidLoad()
        }
    }

    @IBAction func backAction(_ sender: Any) {
        webView.goBack()
    }
}

