//
//  DataService.swift
//  register
//
//  Created by chenhsiangchun on 2022/3/13.
//

import Foundation
import Firebase

class DataService {
    static let dataService = DataService()
   
    private var user = Database.database().reference().child("users")

    var USER: DatabaseReference {
        return Database.database().reference().child("users")
    }


    func setUserInfo(user : User){
        DataService.dataService.USER.child(user.username).child("email").setValue(user.email)
        DataService.dataService.USER.child(user.username).child("password").setValue(user.password)
    }
}
