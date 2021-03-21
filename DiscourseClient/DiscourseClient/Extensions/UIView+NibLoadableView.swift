//
//  UIView+NibLoadableView.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 17/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
