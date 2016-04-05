//
//  UIImage+ex.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/31.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import CoreImage


func CIImageWithImage(image: UIImage) -> CIImage? {
    return CIImage(image: image)
}

extension UIImage {


    static private let cictx: CIContext = CIContext(EAGLContext: EAGLContext(API: .OpenGLES2))

    static func imageWithColor(color:UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        color.set()
        UIRectFill(CGRectMake(0, 0, size.width, size.height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }

    /**
     使用CoreImage，真机才有效
     */
    func gaussianBlur(radius: Double = 10) -> UIImage? {

        let filter = CIFilter(name: "CIGaussianBlur")

        let inputImg = CIImageWithImage(self)
        filter?.setValue(inputImg, forKey: "inputImage")
        filter?.setValue(radius, forKey: "inputRadius")

        let cgimg = UIImage.cictx.createCGImage(filter!.outputImage!, fromRect: inputImg!.extent)
        
        return UIImage(CGImage: cgimg)
    }
}

