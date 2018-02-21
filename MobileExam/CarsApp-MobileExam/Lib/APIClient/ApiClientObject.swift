//
//  ApiClientObject.swift
//  CarsApp-MobileExam
//
//  Created by Bogdan Pintilei on 2/20/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Foundation

extension APIClient {

    class func getObjects(completion: @escaping (_ levels: [Object]) -> Void) {
        let path = "boats"
        get(path: path) { json in
            if (json as? [[String: AnyObject]]) != nil {
                let boats = Factory.objectsFromJsonArray(jsonArray: json as! [[String: AnyObject]])
                Object.insertItems(objectList: boats)
                completion(boats)
            } else {
                var boats = [Object]()
                if Object.retrieveItems().count != 0 && ConnectivityManager.shared().isConnectedToInternet() == false {
                    boats = Object.retrieveItems()
                }
                completion(boats)
            }

        }
    }

    class func editObject(object: Object, completion: @escaping (_ success: Bool) -> Void) {
        let path = "change"
        let params = objectParams(object)
        post(path: path, params: params) { json in
            if json != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    class func editObjectAttribute(object: Object, completion: @escaping (_ success: Bool) -> Void) {
        let path = "rides"
        let params = objectParamsForAttribute(object)
        post(path: path, params: params) { json in
            if json != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    class func addObject(object: Object, completion: @escaping (_ success: Bool) -> Void) {
        let path = "new"
        let params = objectParamsForAdd(object)
        post(path: path, params: params) { json in
            if json != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    class func deleteObject(id: Int, completion: @escaping (_ success: Bool) -> Void) {
        let path = "boat/\(id)"
        var params = [String: Any]()
        params["id"] = id
        delete(path: path, params: params) { succes in
            if (succes != nil) {
                print("delete succeded")
                completion(true)
            } else {
                print("delete failed")
                completion(false)
            }
        }
    }

    class func objectParams(_ object: Object) -> [String: Any] {
        var params = [String: Any]()

        if let id = object.id {
            params["id"] = id
        }

        if let name = object.name {
            params["name"] = name
        }

        if let status = object.status {
            params["status"] = status
        }

        if let year = object.seats {
            params["seats"] = year
        }

        print(params)
        return params
    }

    class func objectParamsForAttribute(_ object: Object) -> [String: Any] {
        var params = [String: Any]()

        if let id = object.id {
            params["id"] = id
        }

        if let km = object.rides {
            params["rides"] = km
        }

        print("Edit the number of rides: \(params)")
        return params
    }

    class func objectParamsForAdd(_ object: Object) -> [String: Any] {
        var params = [String: Any]()

        if let name = object.name {
            params["name"] = name
        }

        if let model = object.model {
            params["model"] = model
        }

        if let year = object.seats {
            params["seats"] = year
        }

        print(params)
        return params
    }


}
