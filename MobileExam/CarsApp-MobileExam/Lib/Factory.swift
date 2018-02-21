//
//  Factory.swift
//  LanguagesApp
//
//  Created by Bogdan Pintilei on 12/19/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import Foundation

class Factory {

    // MARK: - Levels

    class func objectsFromJsonArray(jsonArray: [[String: AnyObject]]) -> [Object] {
        var objects = [Object]()
        for json in jsonArray {
            objects += [objectFromJson(json: json)]
        }

        return objects
    }

    class func objectFromJson(json: [String: AnyObject]) -> Object {
        var objectID: Int?
        var objectName = String()
        var objectModel = String()
        var objectStatus = String()
        var objectYear: Int?
        var objectKm: Int?

        if let jsonID = json["id"] as? Int {
            objectID = jsonID
        }

        if let jsonName = json["name"] as? String {
            objectName = jsonName
        }

        if let jsonModel = json["model"] as? String {
            objectModel = jsonModel
        }

        if let jsonStatus = json["status"] as? String {
            objectStatus = jsonStatus
        }

        if let jsonSeats = json["seats"] as? Int {
            objectYear = jsonSeats
        } else if let jsonSeats = json["seats"] as? String {
            objectYear = Int(jsonSeats)
        }

        if let jsonRides = json["rides"] as? Int {
            objectKm = jsonRides
        } else if let jsonRides = json["rides"] as?  String {
            objectKm = Int(jsonRides)
        }
        
        if objectKm == nil {
            objectKm = 0
        }
        
        print("Factory: number of rides is: \(objectKm)")

        let object = Object(
            id: objectID,
            name: objectName,
            model: objectModel,
            status: objectStatus,
            seats: objectYear,
            rides: objectKm
        )

        return object
    }

}





 
