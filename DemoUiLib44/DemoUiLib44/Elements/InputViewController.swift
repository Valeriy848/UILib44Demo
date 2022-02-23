//
//  InputViewController.swift
//  DemoUiLib44
//
//  Created by Valeriy on 20.02.2022.
//

import UIKit
import UILib44

internal final class InputViewController: UIViewController, FocusObserverDelegate, InputActionDelegate {
    
    // MARK: - Properties
    
    private let textField = InputTextField(inputTextFieldType: .text, placeholder: "123", label: "Введите 123")
    
    private let buttonMode: UISegmentedControl = {
        let buttonMode = UISegmentedControl(items: ["None","Clear","Custom"])
        buttonMode.selectedSegmentIndex = 0
        buttonMode.addTarget(self, action: #selector(onButtonModeChange), for: .valueChanged)
        buttonMode.translatesAutoresizingMaskIntoConstraints = false
        return buttonMode
    }()
    
    private let requestFocusButton: UIButton = {
        let requestFocusButton = UIButton()
        requestFocusButton.setTitle("Получить фокус", for: .normal)
        requestFocusButton.backgroundColor = CustomColors.blue.color
        requestFocusButton.setTitleColor(CustomColors.levelZero.color, for: .normal)
        requestFocusButton.addTarget(self, action: #selector(requestFocus), for: .touchUpInside)
        requestFocusButton.translatesAutoresizingMaskIntoConstraints = false
        return requestFocusButton
    }()
    
    private let releaseFocusButton: UIButton = {
        let releaseFocusButton = UIButton()
        releaseFocusButton.setTitle("Сбросить фокус", for: .normal)
        releaseFocusButton.backgroundColor = CustomColors.blue.color
        releaseFocusButton.setTitleColor(CustomColors.levelZero.color, for: .normal)
        releaseFocusButton.addTarget(self, action: #selector(releaseFocus), for: .touchUpInside)
        releaseFocusButton.translatesAutoresizingMaskIntoConstraints = false
        return releaseFocusButton
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.actionDelegate = self
        textField.focusObserverDelegate = self
        
        setupUI()
    }
    
    //MARK: - Methods

    private func setupUI() {
        view.backgroundColor = CustomColors.levelZero.color
  
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metrics.topOffset),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.sideOffset),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.sideOffset)
        ])
        
        view.addSubview(buttonMode)
        NSLayoutConstraint.activate([
            buttonMode.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Metrics.topOffset),
            buttonMode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.sideOffset),
            buttonMode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.sideOffset)
        ])
        
        view.addSubview(requestFocusButton)
        NSLayoutConstraint.activate([
            requestFocusButton.topAnchor.constraint(equalTo: buttonMode.bottomAnchor, constant: Metrics.topOffset),
            requestFocusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.sideOffset),
            requestFocusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.sideOffset)
        ])
        
        view.addSubview(releaseFocusButton)
        NSLayoutConstraint.activate([
            releaseFocusButton.topAnchor.constraint(equalTo: requestFocusButton.bottomAnchor, constant: Metrics.topOffset),
            releaseFocusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.sideOffset),
            releaseFocusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.sideOffset)
        ])
    }
    
    @objc private func onButtonModeChange() {
        switch buttonMode.selectedSegmentIndex {
        case 0:
            textField.removeIcon()
        case 1:
            textField.setClearIcon()
        case 2:
            textField.setCustomIcon(icon: CustomIcons.cloud.image, onButtonClick: customButtonAction)
        default:
            break
        }
    }
    
    @objc private func requestFocus() {
        textField.requestFocus()
    }
    
    @objc private func releaseFocus() {
        textField.releaseFocus()
    }
    
    @objc private func getText(_ sender: UIButton) {
        print(textField.text ?? "")
    }
    
    // MARK: - Closures
    
    func endEditingAction() {
        if textField.text != "123" {
            textField.showErrorLabel("Нужно ввести 123")
        } else {
            textField.releaseFocus()
            print("End editing success")
        }
    }

    func returnKeyAction() {
        endEditingAction()
        print("Return key tapped")
    }
    
    func customButtonAction() {
        print("Custom button action")
    }
    
    // MARK: - Focus observer methods
    
    func textFieldGetFocus(sender: InputTextField) {
        if sender == textField {
            print("TextField get focus")
        }
    }

    func textFieldLostFocus(sender: InputTextField) {
        if sender == textField {
            print("TextField lost focus")
        }
    }
}

private extension Metrics {
    static let topOffset: CGFloat = 10
    static let sideOffset: CGFloat = 20
}
