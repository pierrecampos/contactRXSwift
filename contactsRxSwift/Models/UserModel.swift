//
//  UserModel.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 21/11/23.
//

import Foundation


struct UserResonse: Codable {
    let results: [User]
}

struct User: Codable {
    let id: ID
    let name: Name
    var fullName: String {
        return "\(name.first) \(name.last)"
    }
    
    let picture: Picture    
}

struct ID: Codable {
    let name: String
    let value: String
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Picture: Codable {
    let large: String
}
