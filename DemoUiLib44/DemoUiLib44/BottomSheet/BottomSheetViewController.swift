//
//  BottomSheetViewController.swift
//  DemoUiLib44
//
//  Created by Valeriy on 23.02.2022.
//

import UIKit

public final class BottomSheetViewController: UIViewController, BottomSheetViewDelegate {

    // MARK: - Properties

    private var bottomSheetView: BottomSheetView {
        view.originalType()
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Lifecycle

    public override func loadView() {
        view = BottomSheetView()
        bottomSheetView.delegate = self
    }

    public init(controller: UIViewController, theme: UIUserInterfaceStyle) {
        super.init(nibName: nil, bundle: nil)

        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = theme
        }

        modalPresentationStyle = .overFullScreen
        modalPresentationCapturesStatusBarAppearance = true

        setContent(controller: controller)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bottomSheetView.animateBottomSheet()
    }

    // MARK: - Methods

    private func setContent(controller: UIViewController) {
        addChild(controller)
        bottomSheetView.setContent(content: controller.view)
        controller.didMove(toParent: self)
    }

    // MARK: - Bottom sheet protocol

    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if flag {
            bottomSheetView.hideBottomSheet(completion: completion)
        } else {
            super.dismiss(animated: false, completion: completion)
        }
    }

    public func dismiss(animated flag: Bool) {
        dismiss(animated: flag, completion: nil)
    }

    func onBottomSheetClosed(completion: (() -> Void)?) {
        dismiss(animated: false, completion: completion)
    }
}
