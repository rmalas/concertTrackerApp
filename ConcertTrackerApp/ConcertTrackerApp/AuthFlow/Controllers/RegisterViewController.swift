//
//  RegisterViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 6/30/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate,AlertPresenter{
    
    //MARK: IBOutlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    //MARK: Actions
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let userName = userNameTextField.text, let image = profileImageView.image else { /*MARK: Show alert*/ return }
        let sv = Spinner.displaySpinner(onView: self.view)
        FirebaseManager.shared.registerUser(name: userName, password: password, email: email, image: image) { (registered) in
            if registered == false {
                Spinner.removeSpinnerView(spinner: sv)
                self.showAlert(.emailAlreadyExistsAlert)
            } else {
                Spinner.removeSpinnerView(spinner: sv)
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
                    self.present(viewController, animated: true, completion: nil)
                    LoggedInChecker.shared.setTrueToChecker()
            }
        }
        
    }
    
    @IBAction func chooseProfileImageTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.masksToBounds = false
    }
    

}




