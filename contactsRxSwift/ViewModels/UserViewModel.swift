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
    private var usersBehavior = BehaviorRelay<[User]>(value: [])
    var usersObservable: Observable<[User]> {
        return usersBehavior.asObservable()
    }
    
    
    
    func fetchUsers(_ page: Int, _ limit: Int) {
        users = userService.callAPI(page, limit)
        users?.subscribe(onNext: { value in
            self.usersBehavior.accept(self.usersBehavior.value + value)
        
        }).disposed(by: disposeBag)
    }
    
}
