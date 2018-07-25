//
//  LogInViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 6/29/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController,AlertPresenter {
    
    //MARK: IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        let sv = Spinner.displaySpinner(onView: self.view)
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        FirebaseManager.shared.handleLogin(password: password, email: email) { (granted) in
            if granted {
                print(granted)
                Spinner.removeSpinnerView(spinner: sv)
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
                self.present(viewController, animated: true, completion: nil)
            } else {
                Spinner.removeSpinnerView(spinner: sv)
                self.showAlert(.permissionDeniedAlert)
                print(granted)
                print("permission denied")
            }
        }
        
        LoggedInChecker.shared.setTrueToChecker()
        
        
    }
    

}
