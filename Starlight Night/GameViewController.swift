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

    @IBOutlet weak var backMenu: UIButton!

    
    @IBAction func backButtonTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
            backMenu.isHidden = false
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
    }
}

