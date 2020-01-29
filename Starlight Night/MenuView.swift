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

class MenuView:UIViewController{

    @IBOutlet weak var segCont: UISegmentedControl!
    
    @IBAction func playGame(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func changeValue(_ sender: Any) {
        if segCont.selectedSegmentIndex == 0
        {
            UserDefaults.standard.set(2, forKey: "target")
        }else{
            UserDefaults.standard.set(1, forKey: "target")
        }
    }
    override func viewDidLoad() {
        if UserDefaults.standard.integer(forKey: "target") == 1{
            segCont.selectedSegmentIndex = 0
        }else {
            segCont.selectedSegmentIndex = 1
        }
    }
    
 @IBAction func ExitNow(sender: AnyObject) {
     exit(EXIT_SUCCESS)
    }
    //    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    //            AppLinkUtility.fetchDeferredAppLink { (url, error) in
    //                if let error = error {
    //                    print("Received error while fetching deferred app link %@", error)
    //                }
    //                if let url = url {
    //                    if #available(iOS 10, *) {
    //                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    //                        self.target = 2
    //                        UserDefaults.setValue(2, forKey: "target")
    //                    } else {
    //                        UIApplication.shared.openURL(url)
    //                    }
    //                }
    //            }
    //            return true;
    //    }

}
