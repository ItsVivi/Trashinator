//
//  ViewController.swift
//  Trashinator
//
//  Created by Jacob Rowan on 2019-02-02.
//  Copyright © 2019 Trashinators. All rights reserved.
//

import UIKit

class CameraScreenVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // MARK: IB Outlets
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraScreenNavBar: UINavigationItem!
    
    @IBAction func cameraNavBarButton(_ sender: UIBarButtonItem) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = false
        
        present(cameraPicker, animated: true)
    }
    @IBAction func libraryNavBarButton(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLabels()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: Actions
    func initLabels() {
        itemNameLabel.text = "placeholder"
        itemNameLabel.font = UIFont.systemFont(ofSize: 44.0)
        cameraScreenNavBar.title = "Trashinator"
    }
}
