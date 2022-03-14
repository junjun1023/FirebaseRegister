//
//  User.swift
//  register
//
//  Created by chenhsiangchun on 2022/3/13.
//

import Foundation

class User {
    let username : String
    private var _email : String = "init@example.com"
    private var _password : String = "init"

    init(username : String) {
        self.username =  username
    }
    var email: String {
        set{
            _email = newValue
        }
        get{
            return _email
        }
    }
    var password: String {
        set{
            _password = newValue
        }
        get{
            return _password
        }
    }

}
