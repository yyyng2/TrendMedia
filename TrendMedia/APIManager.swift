//
//  APIManager.swift
//  TrendMedia
//
//  Created by Y on 2022/08/24.
//

import Foundation

import Alamofire
import SwiftyJSON

class APIManager {

    static let shared = APIManager()
    
    private init() {}
    
    func getImage(query: String, page: Int, completionHandler: @escaping (JSON) -> () ) {
        
        let url = "\(EndPoint.unsplashURL)?page=\(page)&per_page=10&query=\(query)&client_id=\(APIKey.UNSPLASH)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)"
                
//               
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
