//
//  Button.swift
//  DemoUiLib44
//
//  Created by Valeriy on 20.02.2022.
//

import UIKit
import UILib44

internal final class CustomButton: UIViewController, ButtonTappedDelegate {

    // MARK: - Properties
    
    private var buttonOnView = false
    
    private var button: ButtonConfigureProtocol!
    
    private let titleSegmentedControl: UISegmentedControl = {
        let titleSegmentedControl = UISegmentedControl(items: ["Title left", "Title center"])
        titleSegmentedControl.selectedSegmentIndex = 0
        titleSegmentedControl.addTarget(self, action: #selector(onTitleChange), for: .valueChanged)
        titleSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return titleSegmentedControl
    }()
    
    private let subtitleSegmentedControl: UISegmentedControl = {
        let subtitleSegmentedControl = UISegmentedControl(items: ["With subtitle", "Without subtitle"])
        subtitleSegmentedControl.selectedSegmentIndex = 0
        subtitleSegmentedControl.addTarget(self, action: #selector(onSubtitleChange), for: .valueChanged)
        subtitleSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return subtitleSegmentedControl
    }()
    
    private let iconSegmentedControl: UISegmentedControl = {
        let iconSegmentedControl = UISegmentedControl(items: ["With icon", "Without icon"])
        iconSegmentedControl.selectedSegmentIndex = 0
        iconSegmentedControl.addTarget(self, action: #selector(onIconChange), for: .valueChanged)
        iconSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return iconSegmentedControl
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialiazeButton()
        buttonOnView = true
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = CustomColors.levelZero.color
        
        view.addSubview(titleSegmentedControl)
        NSLayoutConstraint.activate([
            titleSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(subtitleSegmentedControl)
        NSLayoutConstraint.activate([
            subtitleSegmentedControl.topAnchor.constraint(equalTo: titleSegmentedControl.bottomAnchor, constant: 10),
            subtitleSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(iconSegmentedControl)
        NSLayoutConstraint.activate([
            iconSegmentedControl.topAnchor.constraint(equalTo: subtitleSegmentedControl.bottomAnchor, constant: 10),
            iconSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func initialiazeButton() {
        if buttonOnView {
            button.removeFromSuperview()
        }

        button = Button(style: checkStyle()!)
        button.setTitle("Action text")
        button.setSubtitle("Subtitle")
        button.tappedDelegate = self
        
        checkIcon()
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func checkStyle() -> ButtonStyle? {
        switch titleSegmentedControl.selectedSegmentIndex {
        case 0:
            switch subtitleSegmentedControl.selectedSegmentIndex {
            case 0: return ButtonStyle.textLeftWithSubtitle
            case 1: return ButtonStyle.textLeftWithoutSubtitle
            default: break
            }
        case 1:
            switch subtitleSegmentedControl.selectedSegmentIndex {
            case 0: return ButtonStyle.textCenterWithSubtitle
            case 1: return ButtonStyle.textCenterWithoutSubtitle
            default: break
            }
        default:
            fatalError("Unknow style value")
        }
        
        return nil
    }
    
    private func checkIcon() {
        switch iconSegmentedControl.selectedSegmentIndex {
        case 0:
            button.insertIcon(CustomIcons.cloud.image)
        case 1:
            button.removeIcon()
        default:
            fatalError("Unknow icon value")
        }
    }
    
    @objc private func onTitleChange() {
        initialiazeButton()
    }
    
    @objc private func onSubtitleChange() {
        initialiazeButton()
    }
    
    @objc private func onIconChange() {
        initialiazeButton()
    }
    
    // MARK: - Tapped delegate
    
    func buttonTapped() {
        print("Button tapped")
    }
}
