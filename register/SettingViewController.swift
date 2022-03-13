//
//  SettingViewController.swift
//  register
//
//  Created by chenhsiangchun on 2022/3/13.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
    
    let padding: CGFloat = 16
    
    let pwdTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "new password"
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layoutMargins.left = 5
        textField.layoutMargins.right = 5
        return textField
    }()
    
    let againTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "type again"
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layoutMargins.left = 5
        textField.layoutMargins.right = 5
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

    }
    
    
}



extension SettingViewController {
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
            let alert = UIAlertController(title: "Unvalid Password", message: "Different password", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)

            return
        }

        self.navigationController?.popToRootViewController(animated: true)
        
    }
}
