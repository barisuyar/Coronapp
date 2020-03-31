//
//  UIImageView+Extensions.swift
//  GAforME
//
//  Created by Barış Uyar on 10.11.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import UIKit
let imageCache = NSCache<NSString, UIImage>()

public extension UIImageView {
    
    func loadImageWithUrl(urlString: String) {
        
        DispatchQueue.main.async {
            self.image = nil
        }
        
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if let unwrappedError = error {
                    print(unwrappedError)
                    return
                }
                
                if let unwrappedData = data, let downloadedImage = UIImage(data: unwrappedData) {
                    DispatchQueue.main.async(execute: {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                    })
                }
                
            }
            dataTask.resume()
        }
    }
}
