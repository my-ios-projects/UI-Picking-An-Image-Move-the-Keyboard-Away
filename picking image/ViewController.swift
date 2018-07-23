//
//  ViewController.swift
//  picking image
//
//  Created by Taha Magdy on 7/23/18.
//  Copyright © 2018 Taha Magdy. All rights reserved.
//

import UIKit


class ViewController: UIViewController,
    UIImagePickerControllerDelegate, // To be an imagePicker delegate
    UINavigationControllerDelegate,  // To be an imagePicker delegate
    UITextFieldDelegate              // To be a textField delegate
{

    
    
    
    
    @IBOutlet weak var imageViewObj: UIImageView!
    @IBOutlet weak var textField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.delegate = self
    }

    
    
    
    // * Before the view appears, subscribe to (UIKeyboardWillShow, UIKeyboardWillHide)
    override func viewWillAppear(_ animated: Bool) {
        
        // Subscribe to Keyboard Notification willShow.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moveTheKeyboardAway(_:)),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
        
        // Subscribe to keyboard willHide Notification.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getTheViewBack(_:)),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }
    
    
    
    // * Before the view disapear subsubscribe to (UIKeyboardWillShow, UIKeyboardWillHide)
    // * We do not need the notification anymore after the view disappears.
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIKeyboardWillShow,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIKeyboardWillHide,
                                                  object: nil)
        
    }

    

    // Pick and image
    @IBAction func pickImage(_ sender: Any) {
        
        let imagePickerView = UIImagePickerController()
        
        // The imagePickerView show images; so you can select images/vidoes or cancel
        // YES; there is a delegate and it contains two functions
        // the first runs when the cancel button is pressed.
        // the second runs when an iamge is selected.
        imagePickerView.delegate = self
        
        // The source of the image
        // .photoLibrary or .camera
        imagePickerView.sourceType = .photoLibrary

        // Show the view
        present(imagePickerView, animated: true, completion: nil)
    }
    
    

    
    // * imagePicker  pickImage method
    // Called when an image is selected
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Image is selected")
        
        // get the selected image.
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.imageViewObj.image = image
        }
        picker.dismiss(animated: true, completion: nil)
        
        // You can add the line belw to viewWillAppear().
        // cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    
    
    // * imagePicker cancel button method
    // Called when cancel button is selected
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel is pressed")
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    /*
     * notification carries information in the notification.userInfo dictionary.
    */
    @objc func moveTheKeyboardAway(_ notification: Notification) {
        
        let userInfo = notification.userInfo
        let keyboadSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        view.frame.origin.y -= keyboadSize.cgRectValue.height
    } // end moveTheKeyboardAway
    

    // Called when the Notification .UIKeyboardWillHide happens
    // We need to subscribe first.
    @objc func getTheViewBack(_ notification: Notification) {
        
        view.frame.origin.y = 0
    }
    
    
    /*
     * Text Fields methods (delegate)
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }

    
    
} // end ViewController
