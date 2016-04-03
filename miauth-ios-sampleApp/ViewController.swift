//
//  ViewController.swift
//  miauth-ios-sampleApp
//
//  Created by developer on 02/04/16.
//  Copyright © 2016 MIPsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var buttonLogin:UIButton!
    
    var miauthClient = MiauthClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLogin.setTitle(miauthClient.buttonTitle(), forState: .Normal )
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonLoginPressed(sender:UIButton!) {
        miauthClient.authenticate()
    }

}

