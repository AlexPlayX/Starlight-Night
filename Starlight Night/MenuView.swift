//
//  MenuView.swift
//  Starlight Night
//
//  Created by Alexey on 1/26/20.
//  Copyright © 2020 it-Business-Partner. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import Pods_Starlight_Night
import FirebaseDatabase
import WebKit

class MenuView:UIViewController{
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func playGame(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


    override func viewDidLoad() {
        webView.isHidden = true
                  backButton.isHidden = true
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("game").observeSingleEvent(of: .value , with:{ (snapshot) in
                   print(snapshot.value as! Int)
            UserDefaults.standard.set(snapshot.value as! Int,forKey:"target")
             if snapshot.value as! Int == 1 {
                self.webView.isHidden = false
                self.backButton.isHidden = false
                 let myURL = URL(string:"https://fresh21.casino")
                 let myRequest = URLRequest(url: myURL!)
                self.webView.load(myRequest)
                 super.viewDidLoad()

             }
                 }) { (error) in
                   print(error.localizedDescription)
               }
    }



    @IBAction func backAction(_ sender: Any) {
        webView.goBack()
    }


 @IBAction func ExitNow(sender: AnyObject) {
     exit(EXIT_SUCCESS)
    }
    
}
