//
//  UIImage+DownloadImage.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 23/11/23.
//

import UIKit

final class ImageLoader {
    
    enum Error: Swift.Error {
        case urlError
        case canNotParseData
    }
    
    static let shared = ImageLoader()
    private let imageCache = ImageCache()
    
    private init() {}
    
    public func imageOfUrl(_ url: String, completionHandler: @escaping (_ result: Result<UIImage, Error>) -> Void ) {
        guard let url = URL(string: url)
        else { return completionHandler(.failure(.urlError)) }
        
        if let image = imageCache[url] {
            completionHandler(.success(image))
        }
        
        URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else { return completionHandler(.failure(.canNotParseData)) }
                
                if let image = UIImage(data: data) {
                    self?.imageCache.insertImage(image, for: url)
                    completionHandler(.success(image))
                } else {
                    completionHandler(.failure(.canNotParseData))
                }
            }
            
        }.resume()        
    }
}
