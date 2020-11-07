//
//  NetworkService.swift
//  PhotoGallery
//
//  Created by Eduard Galchenko on 07.11.2020.
//

import Alamofire
import SwiftyJSON

enum NetworkResponse<T> {
    case success(_ items: [T])
    case error(_ error: Error)
}

public class NetworkService {
    public static let shared = NetworkService()
    
    func getItems<T>(_ apiUrl: String, completion: @escaping (NetworkResponse<T>) -> Void) {
        var items = [T]()
        
        AF.request(Constants.NetworkURL.baseURL + apiUrl).responseJSON { response in
            if response.value != nil {
                let json = JSON(response.value as Any)
                let results = json.arrayValue
                
                if !apiUrl.contains("photos") {
                    for result in results {
                        let item = Album(userId: result["userId"].intValue, id: result["id"].intValue, title: result["title"].stringValue)
                        items.append(item as! T)
                    }
                } else {
                    for result in results {
                        let item = Photo(albumId: result["albumId"].intValue, id: result["id"].intValue, title: result["title"].stringValue, url: result["url"].stringValue, thumbnailUrl: result["thumbnailUrl"].stringValue)
                        items.append(item as! T)
                    }
                }
                
                completion(.success(items))
            } else {
                guard let error = response.error else {
                    completion(.error(response.error!))
                    return
                }
                completion(.error(error))
            }
        }
    }
    
}
