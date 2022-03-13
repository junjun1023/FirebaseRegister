//
//  User.swift
//  register
//
//  Created by chenhsiangchun on 2022/3/13.
//

import Foundation

class User {
    let username : String
    private var _email : String = "default"
    private var _password : String = "default"

    init(username : String) {
        self.username =  username
    }
    var email: String{
        set{
            _email = newValue
        }
        get{
            return _email
        }
    }
    var password: String{
        set{
            _password = newValue
        }
        get{
            return _password
        }
    }

}
