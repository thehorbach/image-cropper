//
//  ImageVC.swift
//  ImageCropping
//
//  Created by Vyacheslav Horbach on 25/11/16.
//  Copyright © 2016 Vjaceslav Horbac. All rights reserved.
//

import UIKit

class ImageVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!

    override func viewWillAppear(_ animated: Bool) {
        self.imageView.image = image
    }
}
