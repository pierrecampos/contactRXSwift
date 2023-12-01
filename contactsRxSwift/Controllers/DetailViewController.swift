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
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var addressText: UILabel!
    
    @IBOutlet weak var contactStack: UIStackView!
    @IBOutlet weak var addressStack: UIStackView!
    
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
        
        contactStack.layer.cornerRadius = 8
        contactStack.clipsToBounds = true
        addressStack.layer.cornerRadius = 8
        addressStack.clipsToBounds = true
    }
    
    func configureUI() {
        userImage.imageOfUrl(contact.picture.large)
        userNameLabel.text = contact.fullName
        cellNumberButton.setTitle(contact.cell ?? "", for: .normal)
        telephoneNumberButton.setTitle(contact.phone ?? "", for: .normal)
        emailButton.setTitle(contact.email ?? "", for: .normal)
        addressText.text = contact.simplifiedLocation
    }
    
    func bindUI() {
        cellNumberButton.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
        telephoneNumberButton.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(openEmail), for: .touchUpInside)
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
    
    @objc func openEmail(sender: UIButton) {
        guard let email = sender.titleLabel?.text else {return}
        if let emailURL = URL(string: "mailto:\(email)") {
            let application = UIApplication.shared
            if(application.canOpenURL(emailURL)) {
                application.open(emailURL)
            }
        }
    }
}
