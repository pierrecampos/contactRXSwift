//
//  UserService.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 21/11/23.
//

import Foundation
import RxSwift

protocol UserServiceProtocol {
    func callAPI<T: Codable>(_ page: Int, _ limit: Int) -> Observable<T>
}

class UserService: UserServiceProtocol {
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask? = nil    
    
    func callAPI<T: Codable>(_ page: Int, _ limit: Int) -> Observable<T> {
        let url = URL(string: "https://randomuser.me/api/?page=\(page)&results=\(limit)&seed=aaa&nat=br")!
        return Observable.create { emitter in
            self.dataTask = self.session.dataTask(with: url, completionHandler: { data, response, error in
                do {
                    let model: UserResonse = try JSONDecoder().decode(UserResonse.self, from: data ?? Data())
                    emitter.onNext(model.results as! T)
                } catch let error {
                    emitter.onError(error)
                }
                emitter.onCompleted()
            })
            self.dataTask?.resume()
            return Disposables.create {
                self.dataTask?.cancel()
            }
        }
    }
    
    
}
