//
//  APIService.swift
//  rosterbuster
//
//  Created by Saurabh Gupta on 08/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    static let standard = APIService()
    
    private func request(url : String,
                         method: HTTPMethod,
                         parameters: [String: Any]?,
                         headers: HTTPHeaders?,
                         completionHandler: @escaping ([AnyObject]? , Error?) -> Void) {
        let request = Alamofire.request(url, method: method, parameters: parameters, headers: headers).responseJSON { response in
            guard response.result.isSuccess else {
                completionHandler(nil, response.result.error)
                return
            }
            
            guard let value = response.result.value as? [AnyObject] else {
                completionHandler(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Malformed data received"]))
                return
            }
            
            completionHandler(value, nil)
        }
        debugPrint(request)
    }
    
    func getRosters(completionHandler: @escaping (([Roster]?, Error?) -> Void)) {
        let url = "https://get.rosterbuster.com/wp-content/uploads/dummy-response.json"
        var rosters: [Roster] = []
        request(url: url,
                method: .get,
                parameters: nil,
                headers: nil) { [weak self]
                    (response, error) in
                    if let error = error {
                        completionHandler(nil, error)
                        return
                    }
                    
                    if let values = response {
//                        Error handling should be present here for all the error codes designed by backend engineer for this Endpoint. One example is given below.
                        
//                        let status = value["status"] as! String
//                        let errorCode = value["error_code"] as! String
//                        if status == "failure" && errorCode == "1" {
//                            completionHandler(nil, NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid Request"]))
//
//                            return
//                        }
                        
                        do {
                            for value in values {
                                let data = try JSONSerialization.data(withJSONObject: value as Any, options: .prettyPrinted)
                                let decoder = JSONDecoder()
                                let roster = try decoder.decode(Roster.self, from: data)
                                rosters.append(roster)
                            }
                            
                            completionHandler(rosters, nil)
                        } catch let err {
                            print("Err", err)
                            completionHandler(nil, err)
                        }
                    }
        }
    }
}
