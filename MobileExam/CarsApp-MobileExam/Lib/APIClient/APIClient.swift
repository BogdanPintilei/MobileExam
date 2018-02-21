//
//  APIClient.swift
//  CarsApp-MobileExam
//
//  Created by Bogdan Pintilei on 2/20/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    static func get(path: String, params: [String: Any]? = nil, completion: @escaping (_ json: Any?) -> ()) {
        performRequest(path: path, method: .get, params: params, completion: completion)
    }
    
    static func post(path: String, params: [String: Any]? = nil, completion: @escaping (_ json: Any?) -> ()) {
        performRequest(path: path, method: .post, params: params, completion: completion)
    }

    static func delete(path: String, params: [String: Any]? = nil, completion: @escaping (_ json: Any?) -> ()) {
        performRequest(path: path, method: .delete, params: params, completion: completion)
    }
    
    static func patch(path: String, params: [String: Any]? = nil, completion: @escaping (_ json: Any?) -> ()) {
        performRequest(path: path, method: .patch, params: params, completion: completion)
    }
    
    
    // MARK: - Private Functions
    
    private static func performRequest(path: String, method: HTTPMethod, params: [String: Any]?, completion: @escaping (_ json: Any?) -> Void) {
        var requestParams = [String: Any]()
        
        // Move the params from here
        if let p = params {
            requestParams = p
        }
        
        Alamofire.request(urlWithPath(path), method: method, parameters: requestParams).validate().responseJSON { response in
            print("response status code: \(String(describing: response.response?.statusCode))")
            
            completion(response.result.value)
        }
    }

    // MARK: - Helpers

    private static func urlWithPath(_ string: String) -> String {
        var baseUrl: String!
        
        baseUrl = stagingUrl()
        
        return baseUrl + string
    }
    
    private static func stagingUrl() -> String {
        return "http://192.168.100.18:4024/"
    }
    
}

