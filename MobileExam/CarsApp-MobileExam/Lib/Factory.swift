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

        if let jsonYear = json["year"] as? Int {
            objectYear = jsonYear
        } else if let jsonYear = json["year"] as? String {
            objectYear = Int(jsonYear)
        }

        if let jsonKm = json["km"] as? Int {
            objectKm = jsonKm
        } else if let jsonKm = json["km"] as?  String {
            objectKm = Int(jsonKm)
        }

        let object = Object(
            id: objectID,
            name: objectName,
            model: objectModel,
            status: objectStatus,
            year: objectYear,
            km: objectKm
        )

        return object
    }

}





 