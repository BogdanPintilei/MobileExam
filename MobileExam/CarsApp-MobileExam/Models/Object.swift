//
//  Object.swift
//  CarsApp-MobileExam
//
//  Created by Bogdan Pintilei on 2/20/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class Object: NSObject, NSCoding {
    
    var id: Int?
    var name: String?
    var model: String?
    var status: String?
    var km: Int?
    var year: Int?

    init(
        id: Int? = 0,
        name: String? = "",
        model: String? = "",
        status: String? = "",
        year: Int? = 0,
        km: Int? = 0
    ) {
        self.id = id
        self.name = name
        self.model = model
        self.status = status
        self.year = year
        self.km = km
    }


    required init(coder decoder: NSCoder) {
        self.id = decoder.decodeObject(forKey: "id") as? Int
        self.name = decoder.decodeObject(forKey: "name") as? String
        self.model = decoder.decodeObject(forKey: "model") as? String
        self.status = decoder.decodeObject(forKey: "status") as? String
        self.year = decoder.decodeObject(forKey: "year") as? Int
        self.km = decoder.decodeObject(forKey: "km") as? Int
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.model, forKey: "model")
        aCoder.encode(self.status, forKey: "status")
        aCoder.encode(self.year, forKey: "year")
        aCoder.encode(self.km, forKey: "km")
        
    }
}

extension Object {
    static func insertItems(objectList: [Object])
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: objectList)
        UserDefaults.standard.set(data, forKey: "objectList")
    }
    
   static func retrieveItems() -> [Object]{
        var savedList = [Object]()
        
        if let data = UserDefaults.standard.object(forKey: "objectList") as? NSData {
            savedList = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Object]
        }
        
        return savedList
    }
}


