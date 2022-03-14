//
//  MemberViewController.swift
//  register
//
//  Created by chenhsiangchun on 2022/3/13.
//

import UIKit

class MemberViewController: UIViewController {

    let padding: CGFloat = 16
    let pwdButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("CHANGE PASSWORD", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    let logoutButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("log out", for: .normal)
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

extension MemberViewController {
    func initView() {
        
        view.backgroundColor = .white
        self.navigationItem.title = "Hello, \(Defaults.getUsername())"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(self.pwdButton)
        self.pwdButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.pwdButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.pwdButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        self.pwdButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.pwdButton.addTarget(self, action: #selector(pwdBtnPressed), for: .touchUpInside)
        
        
        view.addSubview(self.logoutButton)
        self.logoutButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.logoutButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding).isActive = true
        self.logoutButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.logoutButton.addTarget(self, action: #selector(logoutBtnPressed), for: .touchUpInside)

    }
    
    
}

extension MemberViewController {
    
    @objc func logoutBtnPressed(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pwdBtnPressed(sender: UIButton!) {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
}
