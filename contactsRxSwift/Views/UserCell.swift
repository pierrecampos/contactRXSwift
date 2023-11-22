//
//  Cell.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 21/11/23.
//

import Foundation
import UIKit


class UserCell: UITableViewCell {
    
 
    @IBOutlet weak var userTextLabel: UILabel!
    
    func configureCell(user: User) {
        self.userTextLabel.text = user.name.first
    }
}
