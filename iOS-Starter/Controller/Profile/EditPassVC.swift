//
//  EditPassVC.swift
//  iOS-Starter
//
//  Created by Crocodic MBP-2 on 28/07/18.
//  Copyright © 2018 Crocodic. All rights reserved.
//

import UIKit

class EditPassVC: UIViewController {

    @IBOutlet weak var closeBtn: UIBarButtonItem!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var oldPassFld: FloaticonField!
    @IBOutlet weak var newPassFld: FloaticonField!
    @IBOutlet weak var retypePassFld: FloaticonField!
    
    var viewModel = ProfileVM()
    
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
        saveBtn.target = self
        saveBtn.action = #selector(savePass)
        
        closeBtn.target = self
        closeBtn.action = #selector(close)
    }
    
    /// Setup layout view
    func setupView() {
        
    }
    
    /// Dismiss current view controller
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Save profile update data
    @objc func savePass() {
        let oldPass = oldPassFld.text!
        let newPass = newPassFld.text!
        let retypePass = retypePassFld.text!
        
        LoadIndicatorView.shared.startAnimating()
        viewModel.editPass(oldPass: oldPass, newPass: newPass, retypePass: retypePass, error: { (text) in
            LoadIndicatorView.shared.stopAnimating()
            
            self.cAlertShow(message: text)
        }) { (text) in
            LoadIndicatorView.shared.stopAnimating()
            
            self.cAlertShow(title: nil, message: text, isCancelable: false, action: {
                self.dismiss(animated: true, completion: nil)
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
