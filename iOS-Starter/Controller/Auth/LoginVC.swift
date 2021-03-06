//
//  LoginVC.swift
//  Reprime-Core
//
//  Created by Crocodic MBP-2 on 7/5/18.
//  Copyright © 2018 Crocodic. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var useridFld: FloaticonField!
    @IBOutlet weak var passwordFld: FloaticonField!
    @IBOutlet weak var forgotPassBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!

    let viewModel = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMethod()
        setupView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Setup add function/ action in object (ex: add button action, add delegate, add gesture)
    func setupMethod() {
        forgotPassBtn.addTarget(self, action: #selector(forgotPass), for: .touchUpInside)
        registerBtn.addTarget(self, action: #selector(register), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    /// Set layout view
    func setupView() {
        UITextField.connect(fields: [useridFld, passwordFld])
    }
    
    /// Present forgot password controller modally
    @objc func forgotPass() {
        let vc = StoryboardScene.Auth.forgotPassVC.instantiate()
        self.present(vc, animated: true, completion: nil)
    }
    
    /// Present register controller modally
    @objc func register() {
        let vc = StoryboardScene.Auth.registerVC.instantiate()
        self.present(vc, animated: true, completion: nil)
    }
    
    /// Starting make login request to server
    @objc func login() {
        view.endEditing(true)
        
        LoadIndicatorView.shared.startAnimating()
        
        let userid = useridFld.text!
        let password = passwordFld.text!

        viewModel.login(userid: userid, password: password, error: { (text) in
            self.toastView(message: text)

            LoadIndicatorView.shared.stopAnimating()
        }) { (text) in
            LoadIndicatorView.shared.stopAnimating()

            guard let main = AppDelegate.shared.mainVC else { return }
            self.present(main, animated: true, completion: {
                self.useridFld.text = ""
                self.passwordFld.text = ""
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
