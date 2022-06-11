//
//  LoginViewController.swift
//  Gigs
//
//  Created by Waseem Idelbi on 6/6/22.
//

import UIKit

class LoginViewController: UIViewController {
    
//MARK: - Properties
    // model controller that contains all API methods
    var gigController: GigController?
    var loginType = LoginType.signUp
    
//MARK: - IBOutlets
    @IBOutlet weak var loginTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signButton: UIButton!
    
//MARK: - Methods
    // This will handle presenting the alert controller with proper messaging after attempting to log in or sign up
    func presentSignResultAlert(for loginType: LoginType, result: Bool) {
        var alertTitle = ""
        var alertMessage = ""
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        switch loginType {
        case .logIn:
            switch result {
            case true:
                alertTitle = "Login Successful!"
            case false:
                alertTitle = "Login Failed"
                alertTitle = "Unable to log in with the entered credentials, please double check your credentials and try again"
            }
            
        case .signUp:
            switch result {
            case true:
                alertTitle = "Sign-up Successful!"
                alertMessage = "Your account has been created successfully! Please use your new credentials to log in."
            case false:
                alertTitle = "Sign-up Failed"
                alertMessage = "We were unable to create a new account for you, please choose a different username or try again later."
            }
        }
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
//MARK: - IBAction
    // Activates when the user switched user type via segmented control
    @IBAction func loginTypeValueChanged(_ sender: UISegmentedControl) {
        switch loginTypeSegmentedControl.selectedSegmentIndex {
        case 1:
            loginType = .logIn
            signButton.setTitle("Sign In", for: .normal)
        default:
            loginType = .signUp
            signButton.setTitle("Sign Up", for: .normal)
        }
    }
    // Button used for signing up or signing in
    @IBAction func signButtonTapped(_ sender: UIButton) {
        guard let gigController = gigController,
        let username = usernameTextField.text,
        let password = passwordTextField.text else { return }
        switch loginType {
            
            // When button is tapped for logging in
        case .logIn:
            gigController.sighIn(username: username, password: password) { result in
                DispatchQueue.main.async {
                    do {
                        let isLoggedIn = try result.get()
                        self.presentSignResultAlert(for: .logIn, result: isLoggedIn)
                        self.dismiss(animated: true)
                    } catch {
                        print("ERROR: Login failed with error message: \(error)")
                        self.presentSignResultAlert(for: .logIn, result: false)
                    }
                }
            }
            
            // When button is tapped for signing up
        case .signUp:
            gigController.signUp(username: username, password: password) { result in
                DispatchQueue.main.async {
                    do {
                        let isSignedUp = try result.get()
                        self.presentSignResultAlert(for: .signUp, result: isSignedUp)
                        self.loginTypeSegmentedControl.selectedSegmentIndex = 1
                    } catch {
                        print("ERROR: Sign-Up failed with error message: \(error)")
                        self.presentSignResultAlert(for: .signUp, result: false)
                    }
                }
            }
        }
    }
    
}
