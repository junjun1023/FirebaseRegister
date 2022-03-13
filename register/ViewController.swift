//
//  ViewController.swift
//  register
//
//  Created by chenhsiangchun on 2022/3/10.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let padding: CGFloat = 16
    
    let emailTextField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "account"
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.returnKeyType = .done
        return textField
    }()
    
    let pwdTextField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "password"
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.returnKeyType = .done
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("LOG IN", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initView()
        autoLogin()

    }

    func autoLogin() {
        if let id = emailTextField.text, !id.isEmpty, let pwd = pwdTextField.text, !pwd.isEmpty {
            let username = Defaults.getUsername()
            DataService.dataService.USER.child(username).observeSingleEvent(of: .value, with: {(snapshot) in

                if snapshot.exists() {
                    
                    let emailSp = snapshot.childSnapshot(forPath: "email").value as! String
                    let pwdSp = snapshot.childSnapshot(forPath: "password").value as! String
                    
                    if id.elementsEqual(emailSp), pwd.elementsEqual(pwdSp) {
                        self.successLogin()
                    }
                    
                } else {
                    print("not")
                }
                
            })
        }

    }
    
    func successLogin() {
        self.navigationController?.pushViewController(MemberViewController(), animated: true)
    }
}


extension ViewController {
    func initView() {
        
        view.backgroundColor = .white
        self.navigationItem.title = "Log in"
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(self.emailTextField)
        self.emailTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.emailTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        self.emailTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        emailTextField.delegate = self
        emailTextField.text = Defaults.getEmail()

        view.addSubview(self.pwdTextField)
        self.pwdTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.pwdTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.pwdTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding).isActive = true
        self.pwdTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        pwdTextField.delegate = self
        pwdTextField.text = Defaults.getPassword()
        
        view.addSubview(self.loginButton)
        self.loginButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.loginButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.loginButton.topAnchor.constraint(equalTo: pwdTextField.bottomAnchor, constant: padding).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.loginButton.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)

    }
}

extension ViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func loginBtnPressed(sender: UIButton!) {
        
        
        guard let id = emailTextField.text, !id.isEmpty, let pwd = pwdTextField.text, !pwd.isEmpty else {
            let alert = UIAlertController(title: "Empty Account/Password", message: "Please fill in account/password.", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)

            return
        }

        
        let username = Defaults.getUsername()
        DataService.dataService.USER.child(username).observeSingleEvent(of: .value, with: {(snapshot) in

            if snapshot.exists() {
                
                let emailSp = snapshot.childSnapshot(forPath: "email").value as! String
                let pwdSp = snapshot.childSnapshot(forPath: "password").value as! String
                
                if id.elementsEqual(emailSp), pwd.elementsEqual(pwdSp) {
                    Defaults.saveEmail(email: emailSp)
                    Defaults.savePassword(password: pwdSp)
                    self.successLogin()
                    
                } else {
                    let alert = UIAlertController(title: "Invalid Email/Password", message: "Please correct the email/password", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                
            } else {
                print("not")
            }
            
        })


    }
}
