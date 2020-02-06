//
//  LoginFormController.swift
//  VKApp
//
//  Created by Сергей Зесли on 12.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var item1: UIView!
    @IBOutlet weak var item2: UIView!
    @IBOutlet weak var item3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginInput.delegate = self
        passwordInput.delegate = self
       // self.hideKeyboardWhenTappedAround()
        
        let tapDown = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
         
        scrollView.addGestureRecognizer(tapDown)
         

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.item1.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0.33, options: [.repeat, .autoreverse], animations: {
            self.item2.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0.66, options: [.repeat, .autoreverse], animations: {
            self.item3.alpha = 0
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let login = loginInput.text
        let password = passwordInput.text
        
        if login == "admin" && password == "123456" {
            loginInput.text = nil
            passwordInput.text = nil
            performSegue(withIdentifier: "loginOkSegue", sender: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert,animated: true)
        }
        
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
        view.endEditing(true)
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
