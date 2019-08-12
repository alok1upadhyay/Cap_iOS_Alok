//
//  ImageCache.swift
//
//
//  Created by Alok Upadhyay on 1/3/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
// This is a general purpose simple to use image cache class, SDWebimage / kingfisher can also be used.

import UIKit

class ImageCache {
  
  static let shared = ImageCache()
  private let session: URLSession
  
  
  private let cache: NSCache<NSString,UIImage> = NSCache()
  
  private init(session: URLSession = .shared) {
    self.session = session
  }
  
  private func addImage(key:NSString, image:UIImage) {
    cache.setObject(image, forKey: key)
  }
  private func getImage(key:NSString) -> UIImage? {
    return cache.object(forKey: key)
  }
  
  public func fetchImage(url:URL, callback:@escaping (_ image:UIImage?)->()) {
    
    let aImage = getImage(key: url.absoluteString as NSString)
    
    if aImage != nil{
      
      //make sure to return UIKit objects on main queue
      DispatchQueue.main.async {
        callback(aImage)
      }
      
    }else{
      session.dataTask(with: url) { [weak self] (data, response, error) in
        
        guard
          let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
          let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
          let data = data, error == nil,
          let image = UIImage(data: data)
          else {
            //make sure to return UIKit objects on main queue

            DispatchQueue.main.async {
              callback(nil)
            }
            return
        }
        self?.addImage(key: url.absoluteString as NSString, image: image)
        //make sure to return UIKit objects on main queue
        DispatchQueue.main.async {
          callback(image)
        }
        }.resume()
      
    }
  }
}
