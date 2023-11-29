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
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var cellNumberButton: UIButton!
    @IBOutlet weak var telephoneNumberButton: UIButton!
    
    var contact: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        bindUI()
    }
    
    func configureLayout() {
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFit
    }
    
    func configureUI() {
        userImage.imageOfUrl(contact.picture.large)
        userNameLabel.text = contact.fullName
        cellNumberButton.setTitle(contact.cell ?? "", for: .normal)
        telephoneNumberButton.setTitle(contact.phone ?? "", for: .normal)
    }
    
    func bindUI() {
        cellNumberButton.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
        telephoneNumberButton.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
    }
    
    
    @objc private func callNumber(sender: UIButton) {
        guard let phoneNumber = sender.titleLabel?.text else {return}
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            let application = UIApplication.shared
            if(application.canOpenURL(phoneURL)) {
                application.open(phoneURL)
            }
        }
    }
    
    
    
    
}
