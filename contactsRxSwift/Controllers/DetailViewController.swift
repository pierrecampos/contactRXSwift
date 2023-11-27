//
//  DetailViewController.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 27/11/23.
//

import UIKit
import RxRelay

class DetailViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    
    
    var contact: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }
    
    func configureLayout() {
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFit
    }
    
    func configureUI() {
        userImage.imageOfUrl(contact.picture.large)
    }
    
    
    
    
}
