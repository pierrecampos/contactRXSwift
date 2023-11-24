//
//  UserService.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 21/11/23.
//

import Foundation
import RxSwift

protocol UserServiceProtocol {
    func callAPI<T: Codable>() -> Observable<T>
}

class UserService: UserServiceProtocol {
    let baseURL = URL(string: "https://randomuser.me/api/?page=0&results=20&seed=aaa&nat=br")!
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask? = nil
    
    
    func callAPI<T: Codable>() -> Observable<T> {
        return Observable.create { emitter in
            self.dataTask = self.session.dataTask(with: self.baseURL, completionHandler: { data, response, error in
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
