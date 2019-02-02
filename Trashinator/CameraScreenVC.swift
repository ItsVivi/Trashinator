//
//  ViewController.swift
//  Trashinator
//
//  Created by Jacob Rowan on 2019-02-02.
//  Copyright © 2019 Trashinators. All rights reserved.
//

import UIKit

class CameraScreenVC: UIViewController {

    // MARK: IB Outlets
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var cameraScreenNavBar: UINavigationItem!
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

