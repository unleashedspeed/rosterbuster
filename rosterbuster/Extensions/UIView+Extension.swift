//
//  UIView+Extension.swift
//  rosterbuster
//
//  Created by Saurabh Gupta on 15/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

extension UIView {
    class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
