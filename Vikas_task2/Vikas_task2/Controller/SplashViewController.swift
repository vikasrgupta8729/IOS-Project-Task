//
//  ViewController.swift
//  Vikas_task2
//
//  Created by BATWOMAN on 21/04/23.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //automatically navigate to next screen after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.performSegue(withIdentifier: "splashToTable", sender: nil)
        })
        
    }


}

