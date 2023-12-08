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
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFit
    }
    
    func configureCell(user: User) {
        nameLabel.text = user.fullName
        ImageLoader.shared.imageOfUrl(user.picture.large) { [weak self] result in
            switch result {
            case .success(let image):
                self?.userImage.image = image
            case .failure:
                self?.userImage.image = UIImage(systemName: "person.fill")
            }
        }
    }
    
}
