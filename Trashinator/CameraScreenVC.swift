//
//  ViewController.swift
//  Trashinator
//
//  Created by Jacob Rowan on 2019-02-02.
//  Copyright © 2019 Trashinators. All rights reserved.
//

import UIKit
import CoreML
import Foundation

class CameraScreenVC: UIViewController, UINavigationControllerDelegate {

    let blueList =  ["aerosolCan",
                     "aluminum",
                     "bottle",
                     "steel can",
                     "tin can",
                     "aluminum can",
                     "container",
                     "pot",
                     "pan",
                     "utensil",
                     "book",
                     "bristol board",
                     "boxboard box",
                     "cardboard",
                     "cards catalogue",
                     "cereal box",
                     "coffee cup",
                     "drink tray",
                     "egg carton",
                     "envelope",
                     "fast food bag",
                     "paper bag",
                     "fast food box",
                     "pizza box",
                     "file folder",
                     "flyer",
                     "newspaper",
                     "magazine",
                     "phone book",
                     "plate",
                     "cup",
                     "poster",
                     "sticky note",
                     "wrapping paper bottle",
                     "container",
                     "cupsand dish",
                     "hard plastic packaging",
                     "jug",
                     "medicine bottle",
                     "milk jug",
                     "juice jug",
                     "frozen juice can",
                     "lid",
                     "cover",
                     "milk carton",
                     "juice carton",
                     "styrofoam",
                     "electronic",
                     "plastic bag",
                     "water bottle"]
    
    let clearList = ["balloon",
                     "binder",
                     "board game",
                     "candle",
                     "carbon paper",
                     "cat litter",
                     "chalk",
                     "cigarette butt",
                     "clothes",
                     "linen sheet",
                     "dirt",
                     "dust",
                     "disinfecting wipe",
                     "dryer lint",
                     "sheet",
                     "elastic band",
                     "fabric",
                     "footwear",
                     "furnace",
                     "filter",
                     "latex glove",
                     "rubber glove",
                     "leather",
                     "light bulb",
                     "marker",
                     "crayon",
                     "mirror",
                     "nylon",
                     "pencil",
                     "pen",
                     "pet training waste pad",
                     "pet waste",
                     "photo",
                     "picture frame",
                     "pillow",
                     "pillow case",
                     "pottery",
                     "pyrex",
                     "rubber",
                     "sandpaper",
                     "silica gel pack",
                     "sports equipment",
                     "sticker",
                     "string",
                     "tape",
                     "toys",
                     "transparency",
                     "vacuum bag",
                     "vase",
                     "wallpaper",
                     "yarn",
                     "baby wipe",
                     "bandage",
                     "gauze",
                     "brush",
                     "comb",
                     "colostomy tube feeding bag",
                     "condom",
                     "cosmetics",
                     "cosmetic wipe",
                     "cotton ball",
                     "dental floss",
                     "diaper",
                     "disposable razor",
                     "feminine hygiene product",
                     "q-tip",
                     "toothpaste tube",
                     "towel",
                     "absorbent pad",
                     "ceramic dish",
                     "chip bag",
                     "cork",
                     "dish cloth",
                     "glass",
                     "granola bar",
                     "candy bar wrapper",
                     "parchment paper",
                     "plastic cutlery",
                     "plastic packaging",
                     "plastic wrap",
                     "bubble wrap",
                     "rag",
                     "rubber glove",
                     "scouring pad",
                     "sponge",
                     "single serve coffee pod",
                     "single-use coffee packet",
                     "soft plastic",
                     "straw",
                     "toothpick",
                     "twist tie",
                     "water filter",
                     "softener salt",
                     "waxed paper wrapper"]
    
    let greenList = ["apple",
                     "banana",
                     "bone",
                     "coffee filter",
                     "coffee ground",
                     "cooking grease",
                     "dairy product",
                     "expired food",
                     "fish",
                     "shell fish",
                     "food scrap",
                     "leftover",
                     "fruit",
                     "vegetable",
                     "meat",
                     "oil",
                     "fat",
                     "rotten food",
                     "moldy food",
                     "egg shell",
                     "shellfish shell",
                     "tea bag",
                     "grass clipping",
                     "leaf",
                     "plant",
                     "flower",
                     "weed",
                     "sawdust",
                     "wood chips",
                     "soil",
                     "twig",
                     "branch",
                     "napkin",
                     "paper",
                     "towel",
                     "tissue",
                     "tobacco"]
    
    let hazardList = ["acid",
                      "adhesive",
                      "glue",
                      "aerosol",
                      "antifreeze",
                      "coolant",
                      "glycol",
                      "battery",
                      "car battery",
                      "household bleach",
                      "butane cartridge",
                      "car care product",
                      "caulking",
                      "chemical",
                      "cleaning product",
                      "computer monitor",
                      "cooking oil",
                      "driveway sealant",
                      "fertilizer",
                      "flea powder",
                      "gasoline",
                      "diesel fuel",
                      "herbicide",
                      "fungicide",
                      "kerosene",
                      "light bulb",
                      "lighter",
                      "medication",
                      "prescription",
                      "mercury",
                      "thermometer",
                      "thermostat",
                      "methanol",
                      "mineral spirit",
                      "motor oil",
                      "filter",
                      "nail polish",
                      "remover oven cleaner",
                      "paint",
                      "pesticide",
                      "pool chemical",
                      "polish and wax",
                      "propane tank",
                      "propane cylinder",
                      "rubbing alcohol",
                      "rust remover",
                      "solvent",
                      "stain",
                      "varnish"]
    
    
    // MARK: IB Outlets
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraScreenNavBar: UINavigationItem!
    
    @IBAction func cameraNavBarButton(_ sender: UIBarButtonItem) {
        print("cameraNavBarButton pressed")
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
        print("libraryNavBarButton pressed")
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true)
    }
    
    var model: Inceptionv3!
    
    override func viewWillAppear(_ animated: Bool) {
        model = Inceptionv3()
        print("viewDidAppear, model set to \(model!)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension CameraScreenVC: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("imagePickerControllerDidCancel")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        picker.dismiss(animated: true)
        itemNameLabel.text = "Analyzing Image..."
        print(itemNameLabel.text!)
        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
            return
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 299, height: 299), true, 2.0)
        image.draw(in: CGRect(x: 0, y: 0, width: 299, height: 299))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) // 3
        
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        imageView.image = newImage
        print("imageView.image set to newImage")
        
        guard let prediction = try? model.prediction(image: pixelBuffer!) else {
            return
        }
        itemNameLabel.text = "\(prediction.classLabel)"
        let accuracy = "\(prediction.classLabelProbs)"
        print("The likelyhood of this being accurate is: \(accuracy)%")

        if blueList.contains(String(prediction.classLabel)) {
            print("blue match")
            itemNameLabel.text = "\(prediction.classLabel)s go in the blue garbage"
        } else if greenList.contains(String(prediction.classLabel)) {
            print("green match")
            itemNameLabel.text = "\(prediction.classLabel)s go in the green garbage"
        } else if clearList.contains(String(prediction.classLabel)) {
            print("clear match")
            itemNameLabel.text = "\(prediction.classLabel)s go in the clear garbage"
        } else if hazardList.contains(String(prediction.classLabel)) {
            print("hazard match")
            itemNameLabel.text = "\(prediction.classLabel)s go in the hazardous disposal"
        } else {
            print("no match")
            itemNameLabel.text = "\(prediction.classLabel) does not match any items on the list"
        }
        
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
