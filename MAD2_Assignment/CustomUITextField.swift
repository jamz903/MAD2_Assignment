//
//  CustomUITextField.swift
//  MAD2_Assignment
//
//  Created by Justin Ng on 23/1/21.
//

import Foundation
import UIKit

class CustomUITextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func setPlaceHolderImage(imageName: String) {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.contentMode = .scaleAspectFill
        imgView.image = resizeImage(image: UIImage(named: imageName)!, targetSize: CGSize(width: 30, height: 30)).withInset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        self.leftView = imgView
        self.leftViewMode = .always
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

extension UIImage {
    func withInset(_ insets: UIEdgeInsets) -> UIImage? {
            let cgSize = CGSize(width: self.size.width + insets.left * self.scale + insets.right * self.scale,
                                height: self.size.height + insets.top * self.scale + insets.bottom * self.scale)

            UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
            defer { UIGraphicsEndImageContext() }

            let origin = CGPoint(x: insets.left * self.scale, y: insets.top * self.scale)
            self.draw(at: origin)

            return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
        }
}
