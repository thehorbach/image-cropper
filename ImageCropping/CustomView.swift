//
//  CustomView.swift
//  ImageCropping
//
//  Created by Vyacheslav Horbach on 25/11/16.
//  Copyright © 2016 Vjaceslav Horbac. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    let lineWidth: CGFloat = 2.5
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor?.setFill()
        self.accessibilityPath?.fill()
        self.accessibilityPath?.lineWidth = self.lineWidth
        UIColor.blue.setStroke()
        self.accessibilityPath?.stroke()
    }
    
    init(origin: CGPoint, width: CGFloat,   height: CGFloat) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height))
        
        let insetRect = self.bounds.insetBy(dx: lineWidth, dy: lineWidth)
        self.accessibilityPath = UIBezierPath(roundedRect: insetRect, cornerRadius: 5.0)
        self.backgroundColor = UIColor.clear
        self.center = origin
    
        _cropoptions = CROP_OPTIONS()
        _cropoptions.Center = origin
        _cropoptions.Width = self.bounds.width
        _cropoptions.Height = self.bounds.height

        let panning = UIPanGestureRecognizer(target: self, action: #selector(CustomView.panning(panGR:)))
        addGestureRecognizer(panning)

        //let pinching = UIPinchGestureRecognizer(target: self, action: #selector(CustomView.pinching(pinchGR:)))
        //addGestureRecognizer(pinching)
    }
    
    func panning(panGR: UIPanGestureRecognizer) {
        let translation = panGR.translation(in: self)
        
        self.transform.a += translation.x / 500
        self.transform.d += translation.y / 500
        
        panGR.setTranslation(CGPoint.zero, in: self)
        
        _cropoptions.Center = self.center
        _cropoptions.Height = self.frame.height
        _cropoptions.Width = self.frame.width
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    func panning(panGR: UIPanGestureRecognizer) {
        let translation = panGR.translation(in: self)
        self.center.x += translation.x
        self.center.y += translation.y
        panGR.setTranslation(CGPoint.zero, in: self)
        
        _cropoptions.Center = self.center
    }
    
    func pinching(pinchGR: UIPinchGestureRecognizer) {
        let scale = pinchGR.scale
        self.transform = self.transform.scaledBy(x: scale, y: scale)
        pinchGR.scale = 1.0
        
        _cropoptions.Height = self.frame.height
        _cropoptions.Width = self.frame.width
    }
 */
}
