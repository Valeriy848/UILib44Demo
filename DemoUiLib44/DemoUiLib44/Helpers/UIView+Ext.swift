//
//  UIView+Ext.swift
//  DemoUiLib44
//
//  Created by Valeriy on 23.02.2022.
//

import UIKit

internal extension Optional where Wrapped == UIView {
    func originalType<T: UIView>() -> T {
        return self as! T
    }
}
