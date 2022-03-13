//
//  ViewController.swift
//  register
//
//  Created by chenhsiangchun on 2022/3/10.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let padding: CGFloat = 16
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "account"
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layoutMargins.left = 5
        textField.layoutMargins.right = 5
        return textField
    }()
    
    let pwdTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "password"
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layoutMargins.left = 5
        textField.layoutMargins.right = 5
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

        view.addSubview(self.idTextField)
        self.idTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.idTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.idTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        self.idTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        idTextField.delegate = self

        view.addSubview(self.pwdTextField)
        self.pwdTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.pwdTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.pwdTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: padding).isActive = true
        self.pwdTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        pwdTextField.delegate = self
        
        view.addSubview(self.loginButton)
        self.loginButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.loginButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.loginButton.topAnchor.constraint(equalTo: pwdTextField.bottomAnchor, constant: padding).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.loginButton.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)

    }
}

extension ViewController {
    @objc func loginBtnPressed(sender: UIButton!) {
        
        
        guard let id = idTextField.text, !id.isEmpty, let pwd = pwdTextField.text, !pwd.isEmpty else {
            let alert = UIAlertController(title: "Empty Account/Password", message: "Please fill in account/password.", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)

            return
        }

        
        
        self.navigationController?.pushViewController(MemberViewController(), animated: true)
    }
}
