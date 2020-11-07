//
//  UIImageView+LoadImageInCache.swift
//  PhotoGallery
//
//  Created by Eduard Galchenko on 07.11.2020.
//

import Alamofire
import AlamofireImage

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageInCache(with urlString: String) {
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        AF.request(urlString).responseImage { response in
            if let downloadedImage = response.value {
                imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                self.image = downloadedImage
            }
        }
    }
}
