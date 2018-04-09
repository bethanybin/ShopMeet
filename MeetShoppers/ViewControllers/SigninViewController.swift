//
//  SigninViewController.swift
//  MeetShoppers
//
//  Created by Kelvin Lui on 4/6/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit
import FirebaseAuth

class SigninViewController : UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: BottomBorderedTextField!
    @IBOutlet weak var passwordTextField: BottomBorderedTextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signinView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var profileImage: UIImage?
    var signinViewOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signinButton.backgroundColor = UIColor(rgb: 0x2BC2C2)
        signinButton.layer.cornerRadius = 22
        signinButton.clipsToBounds = true
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Add tap gesture recognizer to dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Initialize original center of sign in view
        signinViewOriginalCenter = signinView.center
    }
    
    // Push sign in view to top when user starts editing in text fields
    func textFieldDidBeginEditing(_ textField: UITextField) {
        logoImageView.isHidden = true
        signinView.center = CGPoint(x: view.center.x, y: view.center.y*0.6)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        logoImageView.isHidden = false
        signinView.center = signinViewOriginalCenter
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignup(_ sender: UIButton) {
        performSegue(withIdentifier: "signupSegue", sender: nil)
    }
    
    @IBAction func onSignin(_ sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if email.count == 0 {
            self.displayMessageDialog(title: "Empty Email", message: "Email is empty. Please try again.")
            return
        }
        
        if password.count == 0 {
            self.displayMessageDialog(title: "Empty password", message: "Password is emtpy. Please try again.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error as NSError? {
                guard let errorCode = AuthErrorCode(rawValue: error.code) else {
                    self.displayMessageDialog(title: "Unknwon Error", message: "Please try again.")
                    return
                }
                
                switch errorCode {
                case .networkError:
                    self.displayMessageDialog(title: "Network Error", message: "Your Internet is too weak. Please try again.")
                case .wrongPassword:
                    self.displayMessageDialog(title: "Incorrect Password", message: "Your password is not correct. Please try again.")
                case .invalidEmail:
                    self.displayMessageDialog(title: "Invalid Email", message: "Please try again.")
                default:
                    self.displayMessageDialog(title: "Unknown Error", message: "Please try again.")
                }
            } else {
                
            }
        }
    }
    
    func displayMessageDialog(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: false, completion: nil)
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
