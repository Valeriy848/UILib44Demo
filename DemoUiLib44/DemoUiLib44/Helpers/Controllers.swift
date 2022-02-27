//
//  Controllers.swift
//  DemoUiLib44
//
//  Created by Valeriy on 28.02.2022.
//

import UIKit

internal enum Controllers: String, CaseIterable {
    case colors
    case icons
    case input
    case button

    var viewController: UIViewController {
        switch self {
        case .colors: return ColorsViewController()
        case .icons: return IconsViewController()
        case .input: return InputViewController()
        case .button: return ButtonViewController()
        }
    }
}
