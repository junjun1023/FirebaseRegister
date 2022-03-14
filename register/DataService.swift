//
//  DataService.swift
//  register
//
//  Created by chenhsiangchun on 2022/3/13.
//

import Foundation
import Firebase

enum FLAG {
    case userAlreadyExist
    case userCreateSuccess
    case userCreateFailed
    case userUpdateSuccess
    case userUpdateFailed
    case userValid
    case userInvalid
    case userUnknown
}


class DataService {
        
    static let dataService = DataService()

    private var USER: DatabaseReference {
        return Database.database().reference().child("users")
    }


    func setUserInfo(user: User){
        DataService.dataService.USER.child(user.username).child("email").setValue(user.email)
        DataService.dataService.USER.child(user.username).child("password").setValue(user.password)
    }
    
    
    func checkUserExists(user: User, completion: @escaping (FLAG)->() ) {
        var exist = FLAG.userUnknown
        if user.username.elementsEqual(Defaults.username) {
            completion(exist)
            return
        }
        
  
        DataService.dataService.USER.child(user.username).observeSingleEvent(of: .value, with: {(snapshot) in
            print("checking")
            if snapshot.exists() {
                print("user exist")
                exist = .userAlreadyExist
                completion(exist)
            } else {
                print("user not exist")
                exist = .userUnknown
                completion(exist)
            }
            
        })

        return
    }
    
    func createNewUser(user: User, completion: @escaping (FLAG)->() ) {
        checkUserExists(user: user, completion: { flag in

            switch flag {
            case .userUnknown:
                if !user.email.elementsEqual(Defaults.email), !user.username.elementsEqual(Defaults.username),
                   !user.password.elementsEqual(Defaults.password) {
                    
                    let userInfo: [String: String] = [
                        "email": user.email,
                        "password": user.password
                    ]
                    DataService.dataService.USER.child(user.username).setValue(userInfo)
                    completion(FLAG.userCreateSuccess)
                }
            default:
                completion(FLAG.userCreateFailed)
                print("not to create new user")
            }
        })

    }
    
    
    func updateUserInfo(user: User, completion: @escaping (FLAG)->() )  {
        
        checkUserExists(user: user, completion: { flag in
            
            switch flag {
            case .userAlreadyExist:
                if !user.password.elementsEqual(Defaults.password) {
                    DataService.dataService.USER.child(user.username).updateChildValues(["password": user.password])
                    completion(FLAG.userUpdateSuccess)
                } else {
                    completion(FLAG.userUpdateFailed)
                }
                
                
            default:
                completion(FLAG.userUpdateFailed)
                print("not to update user")
            }
        })

    }
    
    
    func checkUserValid(user: User, completion: @escaping (FLAG)->()) {
        checkUserExists(user: user, completion: { flag in
            
            switch flag {
            case .userAlreadyExist:
                DataService.dataService.USER.child(user.username).observeSingleEvent(of: .value, with: {(snapshot) in
                    let value = snapshot.value as! Dictionary<String, Any>
                    let email = value["email"] as! String
                    let password = value["password"] as! String
                    print(value, email, password)
                    if user.email.elementsEqual(email), user.password.elementsEqual(password) {
                        completion(FLAG.userValid)
                    } else {
                        completion(FLAG.userInvalid)
                    }
                    
                })
                
                
            default:
                completion(FLAG.userInvalid)
                print("user invalid")
            }
        })

    }
}
