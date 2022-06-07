//
//  LoginViewController.swift
//  Gigs
//
//  Created by Waseem Idelbi on 6/6/22.
//

import UIKit

class LoginViewController: UIViewController {

//MARK: - IBOutlets
    @IBOutlet weak var userTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signButtonTapped: UIButton!
    
//MARK: - IBAction
    // Activates when the user switched user type via segmented control
    @IBAction func userTypeValueChanged(_ sender: UISegmentedControl) {
    }
    // Button used for signing up or signing in
    @IBAction func signButtonTapped(_ sender: UIButton) {
    }
    
}
