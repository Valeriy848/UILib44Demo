//
//  ViewController.swift
//  DemoUiLib44
//
//  Created by Valeriy on 19.02.2022.
//

import UIKit
import UILib44

class ViewController: UIViewController {

    @IBOutlet weak var modeSwitcher: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onShowTap(_ sender: Any) {
        print("Show")
    }
}
