//
//  SigninViewController.swift
//  MeetShoppers
//
//  Created by Kelvin Lui on 4/6/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit

class SigninViewController : UIViewController {

    @IBOutlet weak var usernameTextField: BottomBorderedTextField!
    @IBOutlet weak var passwordTextField: BottomBorderedTextField!
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signinButton.backgroundColor = UIColor(rgb: 0x2BC2C2)
        signinButton.layer.cornerRadius = 22
        signinButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignup(_ sender: UIButton) {
        performSegue(withIdentifier: "signupSegue", sender: nil)
    }
    
    @IBAction func onSignin(_ sender: UIButton) {
    
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
