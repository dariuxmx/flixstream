//
//  ConfigVariables.swift
//
//  Created by Edwin Dario Gutierrez Pech
//  Copyright © 2020  All rights reserved.
//

import UIKit
//import Firebase

class ConfigVariables {
    static let shared = ConfigVariables()
    
    var apiBaseURL: String?
    var apiKey: String?
    
    //Initializer
    private init(){}
    
    func readConfigFile () {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData: [String: AnyObject] = [:]
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path) {
            
            do {
                plistData = try PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
                apiBaseURL = plistData["ApiBaseURL"] as? String
                apiKey = plistData["ApiKey"] as? String
    
            } catch {
                print("Error reading plist: \(error), format: \(propertyListFormat)")
            }
        }
    }
}
