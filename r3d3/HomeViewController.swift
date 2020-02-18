//
//  ViewController.swift
//  r3d3
//
//  Created by HG on 2/2/17.
//  Copyright © 2017 HG. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var login: UIView!
    
    @IBOutlet weak var register: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func segmentedController(_ sender: UISegmentedControl) {
        
        if(sender.selectedSegmentIndex == 0){
        
            UIView.animate(withDuration: 0.5, animations: { 
                self.login.alpha = 0.0
                self.register.alpha = 1.0
            })
        
        }else{
        UIView.animate(withDuration: 0.5, animations: { 
            self.login.alpha = 1.0
            self.register.alpha = 0.0
        })
        
        }
        
    }

  
}











































