//
//  ViewController.swift
//  picking image
//
//  Created by Taha Magdy on 7/23/18.
//  Copyright © 2018 Taha Magdy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {

    
    
    
    
    @IBOutlet weak var imageViewObj: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    
    
    // Pick and image
    @IBAction func pickImage(_ sender: Any) {
        
        let imagePickerView = UIImagePickerController()
        imagePickerView.delegate = self
        
        // The source of the image
        // .photoLibrary or .camera
        imagePickerView.sourceType = .photoLibrary
        
        // Show the view
        present(imagePickerView, animated: true, completion: nil)
    }
    
    

    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("Image is selected")
        
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.imageViewObj.image = image
        }
        picker.dismiss(animated: true, completion: nil)
        
        // You can add the line belw to viewWillAppear().
        // cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel is pressed")
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
} // end ViewController
