//
//  ViewController.swift
//  ImageCropping
//
//  Created by Vyacheslav Horbach on 25/11/16.
//  Copyright © 2016 Vjaceslav Horbac. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var cropView: CustomView!
    
    var imageView: UIImageView!
    let picker = UIImagePickerController()
    var chosenImage: UIImage!
    var added = false
    var imageViewRect: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(frame: self.view.frame)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        
        picker.delegate = self
    }
    
    func makeCropAreaVisible(){ //making selected crop area
        //cropView.removeFromSuperview()
        cropView = nil
        
        let min: CGFloat = imageViewRect.size.height > imageViewRect.size.width ? imageViewRect.size.width:imageViewRect.size.height
        
        cropView = CustomView(origin: self.view.center, width: 100.0, height: 100.0)
        self.view.addSubview(cropView)
    }
    
    func calculateRect(){ // getting same value from the image
        imageViewRect = AVMakeRect(aspectRatio: chosenImage.size, insideRect: imageView.bounds)
        print (" Image Frame height:\(imageViewRect.size.height) width:\(imageViewRect.size.width) and x,y =( \(imageViewRect.origin.x) ,\(imageViewRect.origin.y) )" )
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func addImageButtonDidTouch(_ sender: AnyObject) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = chosenImage
        calculateRect()
        
        if !added {
            self.makeCropAreaVisible()
            added = true
        }
        
        print("now crop area on top \(cropView.frame)")
        dismiss(animated: true, completion: nil)
        print("image found with width \(chosenImage.size.width) and height \(chosenImage.size.height)")
        print("image view frame width \(imageView.frame.width) and height \(imageView.frame.height)")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

