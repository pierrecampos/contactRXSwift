//
//  UIImage+DownloadImage.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 23/11/23.
//

import UIKit

extension UIImageView {
    
    public func imageOfUrl(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(origin: .zero, size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        activityIndicator.startAnimating()
        if self.image == nil {
            self.addSubview(activityIndicator)
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        activityIndicator.removeFromSuperview()
                        self?.image = image
                        
                    }
                } else {
                    self?.image = UIImage(named: "person.fill")
                }
            }
        }
        
    }
}
