//
//  BottomSheetViewController.swift
//  PopcornKit
//
//  Created by v.pokatilo on 16.09.2021.
//

import UIKit
import UILib44

internal final class BottomSheetViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - Properties

    private let bottomSheetHeight: CGFloat
    private var topConstraint: NSLayoutConstraint!

    private let content = BottomSheetView()
    private let bottomSheetView = UIView()
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = CustomColors.gray.color
        backgroundView.alpha = 0
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()

    private let dragElement: UIImageView = {
        let dragElement = UIImageView()
        // TODO: - Заменить на иконку из UILib44
        dragElement.image = UIImage(named: "dragElement")
        dragElement.tintColor = UIColor.black
        dragElement.translatesAutoresizingMaskIntoConstraints = false
        return dragElement
    }()

    private lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: #selector(handlePan))
        return pan
    }()
    
    // MARK: - Lifecycle

    init(mode: UIUserInterfaceStyle) {
        let window = UIApplication.shared.keyWindow
        let topSafeAreaInsets = window?.safeAreaInsets.top ?? 0
        let screenHeight = UIScreen.main.bounds.height
        
        bottomSheetHeight = screenHeight - topSafeAreaInsets

        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .overFullScreen
        overrideUserInterfaceStyle = mode
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateBottomSheet()
    }

    // MARK: - UI

    private func setupUI() {
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        bottomSheetView.addGestureRecognizer(panGesture)
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.bottomAnchor)
        
        view.addSubview(bottomSheetView)
        NSLayoutConstraint.activate([
            topConstraint,
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomSheetView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        bottomSheetView.addSubview(dragElement)
        NSLayoutConstraint.activate([
            dragElement.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
            dragElement.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor)
        ])

        content.layer.cornerRadius = Metrics.cornerRadius
        content.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        content.clipsToBounds = true

        bottomSheetView.addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: dragElement.bottomAnchor),
            content.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
        ])
    }

    // MARK: - Bottom sheet actions

    private func animateBottomSheet() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: Metrics.animationDuration, animations: {
            self.topConstraint.constant = -self.bottomSheetHeight
            self.backgroundView.alpha = Metrics.backgroundViewAlpha
            self.view.layoutIfNeeded()
        })
    }

    private func hideBottomSheet() {
        UIView.animate(withDuration: Metrics.animationDuration) {
            self.topConstraint.constant = 0
            self.backgroundView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }

    // MARK: - Gesture actions

    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: bottomSheetView)
        let yTranslationMagnitude = translation.y.magnitude

        switch sender.state {
        case .began, .changed:
            guard translation.y > 0 else { return }
            topConstraint.constant = yTranslationMagnitude - bottomSheetHeight
            view.layoutIfNeeded()
        case .ended:
            if yTranslationMagnitude >= bottomSheetHeight / 2 {
                hideBottomSheet()
            } else {
                animateBottomSheet()
            }
        case .failed:
            animateBottomSheet()
        default: break
        }
    }
}

private extension Metrics {
    static let backgroundViewAlpha: CGFloat = 0.6
}
