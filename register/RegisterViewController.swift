//
//  RegisterViewController.swift
//  register
//
//  Created by chenhsiangchun on 2022/3/14.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    let padding: CGFloat = 16
 
    let usernameTextField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "username"
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.returnKeyType = .done
        return textField
    }()
    
    let emailTextField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "email"
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
    
    let registerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("REGISTER", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    let cancelButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension RegisterViewController {
    func initView() {
        
        view.backgroundColor = .white
        self.navigationItem.title = "Register"
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true

        
        view.addSubview(self.usernameTextField)
        self.usernameTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.usernameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        self.usernameTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        usernameTextField.delegate = self
//        usernameTextField.text = Defaults.username
        
        view.addSubview(self.emailTextField)
        self.emailTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.emailTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: padding).isActive = true
        self.emailTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        emailTextField.delegate = self
//        emailTextField.text = Defaults.email

        view.addSubview(self.pwdTextField)
        self.pwdTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.pwdTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.pwdTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding).isActive = true
        self.pwdTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        pwdTextField.delegate = self
//        pwdTextField.text = Defaults.password


        view.addSubview(self.registerButton)
        self.registerButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.registerButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.registerButton.topAnchor.constraint(equalTo: pwdTextField.bottomAnchor, constant: padding).isActive = true
        self.registerButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.registerButton.addTarget(self, action: #selector(registerBtnPressed), for: .touchUpInside)
        
        
        view.addSubview(self.cancelButton)
        self.cancelButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.cancelButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding).isActive = true
        self.cancelButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.cancelButton.addTarget(self, action: #selector(cancelBtnPressed), for: .touchUpInside)

    }
}


extension RegisterViewController {
    @objc func registerBtnPressed(sender: UIButton) {
        
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let pwd = pwdTextField.text, !pwd.isEmpty else {
            let alert = UIAlertController(title: "Empty Username/Email/Password", message: "Please fill in username/email/password.", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)

            return
        }
        
        
        Defaults.saveUsername(username: username)
        Defaults.saveEmail(email: email)
        Defaults.savePassword(password: pwd)
        
        let user = Defaults.getUserInfo()

        DataService.dataService.createNewUser(user: user, completion: { flag in
            if flag == .userCreateSuccess {
                self.backToLoginViewController()
            } else {
                let alert = UIAlertController(title: "Oops", message: "Something are going wrong", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)

                return
            }
        })

        
    }
    
    
    @objc func cancelBtnPressed(sender: UIButton) {
        backToLoginViewController()
    }
    
    
    func backToLoginViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
