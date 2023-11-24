//
//  UserTableViewCell.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 22/11/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        self.layoutIfNeeded()
        configureLayout()
    }
    
    func configureLayout() {
        userImage.layer.cornerRadius = 8
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFit
    }
    
    func configureCell(user: User) {
        nameLabel.text = user.fullName
        userImage.imageOfUrl(user.picture.large)
    }
    
}
