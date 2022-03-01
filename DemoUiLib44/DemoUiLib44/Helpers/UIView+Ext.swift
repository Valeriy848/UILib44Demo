//
//  UIView+Ext.swift
//  DemoUiLib44
//
//  Created by Valeriy on 23.02.2022.
//

import UIKit

internal extension Optional where Wrapped == UIView {
    func originalType<T: UIView>() -> T {
        // swiftlint:disable force_cast
        return self as! T
        // swiftlint:enable force_cast
    }
}
