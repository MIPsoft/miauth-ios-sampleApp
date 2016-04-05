//
//  miauthClient.swift
//  miauth-ios-sampleApp
//
//  Created by developer on 03/04/16.
//  Copyright © 2016 MIPsoft. All rights reserved.
//

import Foundation
import UIKit

class MiauthClient {
    static let sharedInstance = MiauthClient()
    
    init() {
        print("testi");
    }
    
    private func miauthIsInstalled() -> Bool {
        if let miauthURL:NSURL = NSURL(string:"miauth://test") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(miauthURL)) {
                return true
            }
        }
        return false
    }
    
    func buttonTitle() -> String {
        if  !miauthIsInstalled() {
            return "Asenna miauth-sovellus";
        }
        else {
            return "Tunnistaudu miauth-sovelluksella"
        }
    }
    
    func authenticate() -> Bool {
        if let miauthURL:NSURL = NSURL(string:"miauth://authenticate?callbackurl=com.mipsoft.miauth-ios-sampleApp&app=miAuth-esimerkkiohjelma") {
            let application:UIApplication = UIApplication.sharedApplication()
            application.openURL(miauthURL);
            return true
        }
        return false
    }

}


