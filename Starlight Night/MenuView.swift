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

class MenuView:UIViewController{

    //@IBOutlet weak var segCont: UISegmentedControl!
    
    @IBAction func playGame(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("game").observeSingleEvent(of: .value , with:{ (snapshot) in
                   print(snapshot.value as! Int)
            UserDefaults.standard.set(snapshot.value as! Int,forKey:"target")
                 }) { (error) in
                   print(error.localizedDescription)
               }
    }
    
 @IBAction func ExitNow(sender: AnyObject) {
     exit(EXIT_SUCCESS)
    }
}
