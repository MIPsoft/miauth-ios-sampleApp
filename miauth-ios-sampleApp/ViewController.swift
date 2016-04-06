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
    @IBOutlet weak var textViewStatus:UITextView!
    
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
        miauthClient.authenticate( {self.gotBackFromOtherApp() })
    }
    
    func gotBackFromOtherApp() {
        switch miauthClient.authenticationState {
        case .Ok:
            textViewStatus.text = "Sovellukseen on kirjauduttu."
        case .Fail:
            textViewStatus.text = "Kirjautuminen on peruttu."
        default:
            textViewStatus.text = ""
        }
        
        if let name = miauthClient.authenticationData["name"] {
            textViewStatus.text = textViewStatus.text + "\n\nNimi = \(name)"
        }
        if let email = miauthClient.authenticationData["email"] {
            textViewStatus.text = textViewStatus.text + "\n\nEmail = \(email)"
        }
        
    }

}

