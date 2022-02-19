//
//  BottomSheetView.swift
//  DemoUiLib44
//
//  Created by Valeriy on 19.02.2022.
//

import UIKit
import UILib44

internal final class BottomSheetView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = CustomColors.levelZero.color
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
