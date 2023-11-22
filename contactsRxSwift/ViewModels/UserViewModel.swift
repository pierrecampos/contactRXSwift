//
//  UserViewModel.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 21/11/23.
//

import Foundation
import RxSwift
import RxRelay


class UserViewModel {
    private let disposeBag = DisposeBag()
    
    let userService = UserService()
    var users: Observable<[User]>?
    
    func fetchUsers() {
        users = userService.callAPI()
    }
    
}
