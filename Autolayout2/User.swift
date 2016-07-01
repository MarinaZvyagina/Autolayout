//
//  User.swift
//  Autolayout2
//
//  Created by Марина Звягина on 01.07.16.
//  Copyright © 2016 Марина Звягина. All rights reserved.
//

import Foundation

struct User
{
    let name: String
    let company: String
    let login: String
    let password: String
    
    static func login(login: String, password: String) -> User? {
        if let user = database[login] {
            if user.password == password {
                return user
            }
        }
        return nil
    }
    
    static let database: Dictionary<String, User> = {
        
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name: "Marina Zvyagina", company: "Apple", login: "zaykazzz", password: "qwe"),
            User(name: "Bad Guy", company: "Criminals, Inc.", login: "baddie", password: "foo")
            ] {
                theDatabase[user.login] = user
        }
        return theDatabase
    }()
}