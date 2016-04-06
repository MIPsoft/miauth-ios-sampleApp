//
//  miauthClient.swift
//  miauth-ios-sampleApp
//
//  Created by developer on 03/04/16.
//  Copyright © 2016 MIPsoft. All rights reserved.
//

import Foundation
import UIKit

enum AuthenticationState {
    case Unknown
    case Ok
    case Fail
}


class MiauthClient {
    static let sharedInstance = MiauthClient()
    var registeredCallback: [()->()] =  []
    var authenticationState: AuthenticationState = .Unknown
    var authenticationData: [String: String] = [:]
    
    init() {
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
    
    func authenticate( callback:()->() ) -> Bool {
        if let miauthURL:NSURL = NSURL(string:"miauth://authenticate?callbackurl=com.mipsoft.miauth-ios-sampleApp&app=miAuth-esimerkkiohjelma") {
            let application:UIApplication = UIApplication.sharedApplication()
            registeredCallback = [callback]
            application.openURL(miauthURL);
            return true
        }
        return false
    }
    
    func callBackURL(url: NSURL, fromApplication: String?) -> Bool {
        if  fromApplication == "com.mipsoft.miauth" {
            print("Received \(url) from \(fromApplication)   host=\(url.host)")
            //TODO: Dynaaminen parseri
            
            if url.host == "authentication" {
                authenticationState = .Fail
                authenticationData = [:]
    
                if let params = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)?.queryItems,
                    data = params.filter({ $0.name == "status" }).first,
                    value = data.value {
                    if value=="true"  {
                        authenticationState = .Ok
                    }
                    authenticationData[data.name] = data.value
                }
                
                for key:String in ["name","email","address"] {
                    if let params = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)?.queryItems,
                        data = params.filter({ $0.name == key}).first,
                        value = data.value {
                        authenticationData[data.name] = value
                    }
                }
                
            } //authenticate
            
            if ( registeredCallback.count>0 ) {
                let function: ()->() = registeredCallback[0]
                function()
            }
            return false;
        }
        return true;
    }

}


