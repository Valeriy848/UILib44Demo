//
//  Controllers.swift
//  DemoUiLib44
//
//  Created by Valeriy on 28.02.2022.
//

import UIKit

internal enum Controllers: String, CaseIterable {
    case Colors
    case Icons
    case Input
    case Button

    var viewController: UIViewController {
        switch self {
        case .Colors: return ColorsViewController()
        case .Icons: return IconsViewController()
        case .Input: return InputViewController()
        case .Button: return ButtonViewController()
        }
    }
}
