//
//  CustomView.swift
//  ImageCropping
//
//  Created by Vyacheslav Horbach on 25/11/16.
//  Copyright © 2016 Vjaceslav Horbac. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    let lineWidth: CGFloat = 5.0
    
    init(origin: CGPoint, width: CGFloat,   height: CGFloat) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height))
        _cropoptions = CROP_OPTIONS()
        _cropoptions.Center = origin
        let insetRect = self.bounds.insetBy(dx: lineWidth, dy: lineWidth)
        self.accessibilityPath = UIBezierPath(roundedRect: insetRect, cornerRadius: 0.0)
        self.center = origin
        
       // self.fillColor = UIColor(red: 0.09, green: 0.56, blue: 0.8, alpha: 0.2)
        self.backgroundColor = UIColor(red: 0.09, green: 0.56, blue: 0.8, alpha: 0.2)
        
        _cropoptions.Width = self.bounds.width
        _cropoptions.Height = self.bounds.height
        self.backgroundColor = UIColor.clear
        
        let panning = UIPanGestureRecognizer(target: self, action: #selector(CustomView.panning(panGR:)))
        addGestureRecognizer(panning)
        
        let pinching = UIPinchGestureRecognizer(target: self, action: #selector(CustomView.pinching(pinchGR:)))
        addGestureRecognizer(pinching)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func panning(panGR: UIPanGestureRecognizer) {
        //self.superview!.bringSubview(toFront: self)
        
        //var translation = panGR.translation(in: self)
        
        //translation = translation.applying(self.transform)
        
        //self.center.x += translation.x
        //self.center.y += translation.y
        //panGR.setTranslation(CGPoint.zero, in: self)
        
        let translation = panGR.translation(in: self)
        self.center.x += translation.x
        self.center.y += translation.y
        panGR.setTranslation(CGPoint.zero, in: self)
        
        _cropoptions.Center = self.center
    }
    
    func pinching(pinchGR: UIPinchGestureRecognizer) {
        //self.superview!.bringSubview(toFront: self)
     
        let scale = pinchGR.scale
        self.transform = self.transform.scaledBy(x: scale, y: scale)
        pinchGR.scale = 1.0
        
        _cropoptions.Height = self.frame.height
        _cropoptions.Width = self.frame.width
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor?.setFill()
        self.accessibilityPath?.fill()
        self.accessibilityPath?.lineWidth = self.lineWidth
        UIColor.white.setStroke()
        self.accessibilityPath?.stroke()
    }
}
