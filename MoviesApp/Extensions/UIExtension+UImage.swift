//
//  UIExtension+UImage.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 14/07/24.
//

import Foundation
import UIKit

extension UIImageView  {
    func downloadImage(url: URL?, defaultImage: UIImage?) {
        getdata(url: url!) { data, response, error in
            
            if error != nil {
                DispatchQueue.main.async {
                    self.image = defaultImage
                }
            }
            guard let data = data else { return}
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
    
    func getdata(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
