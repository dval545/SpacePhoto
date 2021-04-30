//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Admin1 on 2/10/20.
//  Copyright © 2020 Admin1. All rights reserved.
//

import Foundation

// The url can be a video, in this case add a query like this "date": "2006-08-15"

struct PhotoInfoController{
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void){
        let baseUrl = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let query: [String: String] = [
            "api_key" : "DEMO_KEY"
            ]
        
        let url = baseUrl.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfo)
            } else {
                print("No data was returned")
                completion(nil)
            }
        }
        task.resume()
        
    }
    
}
