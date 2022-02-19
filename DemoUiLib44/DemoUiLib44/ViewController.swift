//
//  ViewController.swift
//  DemoUiLib44
//
//  Created by Valeriy on 19.02.2022.
//

import UIKit
import UILib44

internal final class ViewController: UIViewController {

    @IBOutlet weak var modeSwitcher: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onShowTap(_ sender: Any) {
        let bottomSheet = BottomSheetViewController(mode: calculateMode())
        present(bottomSheet, animated: false, completion: nil)
    }
    
    private func calculateMode() -> UIUserInterfaceStyle {
        switch modeSwitcher.selectedSegmentIndex {
        case 1: return .light
        case 2: return .dark
        default: return .unspecified
        }
    }
}
