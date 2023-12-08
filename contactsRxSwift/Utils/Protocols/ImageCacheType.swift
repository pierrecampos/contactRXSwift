//
//  ImageCacheType.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 08/12/23.
//

import Foundation
import UIKit

protocol ImageCacheType: AnyObject {
    // Returns the image
    func image(for url: URL) -> UIImage?
    // Inserts the image of the specified url in the cache
    func insertImage(_ image: UIImage?, for url: URL)
    //Removes the image of the especified url in the cache
    func removeImage(for url: URL)
    // Removes all images from the cache
    func removeAllImages()
    // Accesses the value associated with the given key for reading and writing
    subscript(_ url: URL) -> UIImage? { get set }
    
}
