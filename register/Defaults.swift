//
//  Defaults.swift
//  register
//
//  Created by chenhsiangchun on 2022/3/13.
//

import Foundation

class Defaults {
    static private(set) var username = "jane"
    static private(set) var email = "jane@example.com"
    static private(set) var password = "12345678"
    
    static func saveUsername(username: String){
        UserDefaults.standard.set(username, forKey: "Username")
    }

    static func getUsername() -> String {
        if let userId = UserDefaults.standard.string(forKey: "Username") {
            return userId
        }else{
            saveUsername(username: username)
            return username
        }
    }
    
    static func savePassword(password: String){
        UserDefaults.standard.set(password, forKey: "Password")
    }

    static func getPassword() -> String {
        if let pwd = UserDefaults.standard.string(forKey: "Password") {
            return pwd
        }else{
            savePassword(password: password)
            return password
        }
    }
    
    static func saveEmail(email: String){
        UserDefaults.standard.set(email, forKey: "Email")
    }

    static func getEmail() -> String {
        if let email = UserDefaults.standard.string(forKey: "Email") {
            return email
        }else{
            saveEmail(email: self.email)
            return email
        }
    }
}
