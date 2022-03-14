//
//  SettingViewController.swift
//  register
//
//  Created by chenhsiangchun on 2022/3/13.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
    
    let padding: CGFloat = 16
    
    let pwdTextField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "new password"
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let againTextField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "type again"
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("SUBMIT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    let cancelButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("CANCEL", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }


}

extension SettingViewController {
    func initView() {
        
        view.backgroundColor = .white
        self.navigationItem.title = "Change password"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(self.pwdTextField)
        self.pwdTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.pwdTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.pwdTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        self.pwdTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        pwdTextField.delegate = self

        view.addSubview(self.againTextField)
        self.againTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.againTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.againTextField.topAnchor.constraint(equalTo: pwdTextField.bottomAnchor, constant: padding).isActive = true
        self.againTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        againTextField.delegate = self
        
        view.addSubview(self.submitButton)
        self.submitButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.submitButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.submitButton.topAnchor.constraint(equalTo: againTextField.bottomAnchor, constant: padding).isActive = true
        self.submitButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.submitButton.addTarget(self, action: #selector(submitBtnPressed), for: .touchUpInside)
        
        view.addSubview(self.cancelButton)
        self.cancelButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.cancelButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding).isActive = true
        self.cancelButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.cancelButton.addTarget(self, action: #selector(cancelBtnPressed), for: .touchUpInside)

    }
    
    
}



extension SettingViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func submitBtnPressed(sender: UIButton!) {
        
        
        guard let pwd = pwdTextField.text, !pwd.isEmpty, let again = againTextField.text, !again.isEmpty else {
            let alert = UIAlertController(title: "Empty Password", message: "Please finish password.", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)

            return
        }

        
        guard again.elementsEqual(pwd) else {
            let alert = UIAlertController(title: "Invalid Password", message: "Different password", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)

            return
        }
        
        Defaults.savePassword(password: pwd)
        
        let user = Defaults.getUserInfo()
        
        DataService.dataService.updateUserInfo(user: user, completion: { flag in
            if flag == .userUpdateSuccess {
                self.navigationController?.popToRootViewController(animated: true)
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
    
    
    @objc func cancelBtnPressed(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
        
    }
}
