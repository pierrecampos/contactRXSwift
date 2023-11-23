//
//  UserTableViewCell.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 22/11/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(user: User) {
        nameLabel.text = user.name.first
    }
    
}
