//
//  HelpersEmailVC.swift
//  InfoDogs
//
//  Created by Никита Ерофеев on 28.01.22.
//

import Foundation
import UIKit

extension EmailVC {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Mark: Keyboard notification
    func obsererForShow(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    func observerForHide(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/3.5
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // Mark: Set font for label
    func setFont(){
        emailLabel?.font = UIFont(name: "JacquesFrancois-Regular", size: 25)
    }
    
    // Mark: AttributedString for EmailLabel
    func attrString(str: String?, flagStr: String?, labelText: String? ){
        if emailLabel?.text != defaultMessage{
            if let unwrStr = str,
               let unwrFlag = flagStr{
                let attrString = NSMutableAttributedString(string: unwrStr )
                attrString.addAttributes([.foregroundColor: UIColor.orange, .underlineStyle: NSUnderlineStyle.thick.rawValue, .underlineColor: UIColor.orange], range: NSRange(location: 21, length: unwrFlag.count))
                self.emailLabel?.attributedText = attrString
            }
        }
    }
    
     func registation (textField: UITextField){
        textField.resignFirstResponder()
        
        let defaults = UserDefaults.standard
        
        if let text = textField.text{
            
            if isValidEmail(text) {
                let alert = UIAlertController.init(title: "E-mail верный?", message: "\(text)", preferredStyle: .alert)
                let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
                    self.emailLabel?.text = "Новости приходят на: \(text)\n Изменить?"
                    self.flagTFText = text
                    self.attrString(str: self.emailLabel?.text, flagStr: text, labelText: self.emailLabel?.text)
                    defaults.set(self.emailLabel?.text, forKey: "Email")
                    defaults.set(self.flagTFText, forKey: "Text")
                    self.emailTF?.text = nil
                }
                let editAction = UIAlertAction(title: "Изменить", style: .destructive) { action in
                    textField.becomeFirstResponder()
                }
                alert.addAction(saveAction)
                alert.addAction(editAction)
                present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController.init(title: "Не верный формат E-mail", message: "forexample@icloud.com", preferredStyle: .alert)
                let actionEmptyField = UIAlertAction(title: "Продолжить без E-mail", style: .cancel){ action in
                    self.emailTextForSave = self.defaultMessage
                    defaults.set(self.emailTextForSave, forKey: "Email")
                }
                let actionEdit = UIAlertAction (title: "Изменить", style: .default) { action in
                    textField.becomeFirstResponder()
                }
                alert.addAction(actionEmptyField)
                alert.addAction(actionEdit)
                present(alert, animated: true, completion: nil)
                self.emailLabel?.text = self.defaultMessage
                textField.text = nil
                defaults.set(emailTextForSave, forKey: "Email")
            }
        }
    }
    
     func loadData() {
       
        let defaults = UserDefaults.standard
        emailTextForSave = defaults.string(forKey: "Email")
        flagTFText = defaults.string(forKey: "Text")
         if emailTextForSave == nil{
             emailLabel?.text = self.defaultMessage
         } else {
             emailLabel?.text = emailTextForSave
         }
    }
   
}


