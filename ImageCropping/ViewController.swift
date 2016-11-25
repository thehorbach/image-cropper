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
    var croppedImage: UIImage!

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
        cropView = CustomView(origin: self.view.center, width: 100.0, height: 100.0)
        self.view.addSubview(cropView)
    }
    
    func calculateRect(){ // getting same value from the image
        imageViewRect = AVMakeRect(aspectRatio: chosenImage.size, insideRect: imageView.bounds)
        print (" Image Frame height:\(imageViewRect.size.height) width:\(imageViewRect.size.width) and x,y =( \(imageViewRect.origin.x) ,\(imageViewRect.origin.y) )" )
    }
    
    func retriveCroppedImage(){
        let yratio: CGFloat = imageViewRect.size.height / chosenImage.size.height
        let xratio: CGFloat = imageViewRect.size.width / chosenImage.size.width
        
        var cliprect = CGRect(x: _cropoptions.Center.x - _cropoptions.Width/2, y: _cropoptions.Center.y - _cropoptions.Height/2, width: _cropoptions.Width, height: _cropoptions.Height)
        
        print("cliprect top  \(cliprect.size)")
        cliprect.size.height =  cliprect.size.height / xratio;
        cliprect.size.width =  cliprect.size.width / xratio;
        cliprect.origin.x = cliprect.origin.x / xratio + imageViewRect.origin.x  / xratio
        cliprect.origin.y = cliprect.origin.y / yratio - imageViewRect.origin.y  / xratio
        print("cliprect  On Image \(cliprect)")
        
        let imageRef =  chosenImage.cgImage!.cropping(to: cliprect )
        croppedImage  = UIImage(cgImage: imageRef!, scale:  UIScreen.main.scale, orientation: chosenImage.imageOrientation)
        print("Operation complete");
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCroppedImg" {
            
            let destionationVC = segue.destination as! ImageVC
            destionationVC.image = croppedImage
        }
    }
    
    @IBAction func cropButtonDidTouch(_ sender: AnyObject) {
        retriveCroppedImage()
        self.performSegue(withIdentifier: "showCroppedImg", sender: self)
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

