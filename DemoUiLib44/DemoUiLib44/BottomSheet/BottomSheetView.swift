//
//  BottomSheetView.swift
//  DemoUiLib44
//
//  Created by Valeriy on 23.02.2022.
//

import UIKit
import UILib44

internal protocol BottomSheetViewDelegate: AnyObject {
    func onBottomSheetClosed(completion: (() -> Void)?)
}

internal final class BottomSheetView: UIView, UIGestureRecognizerDelegate {

    // MARK: - Properties

    private var topConstraint: NSLayoutConstraint!
    private let bottomSheetHeight: CGFloat
    private let safeArea: UIEdgeInsets

    weak var delegate: BottomSheetViewDelegate?

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private let shadowView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = CustomColors.levelOne.color
        shadowView.alpha = 0
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        return shadowView
    }()

    private let dragElement: UIImageView = {
        let dragElement = UIImageView()
        dragElement.image = CustomIcons.dragElement.image
        dragElement.tintColor = CustomColors.levelOne.color
        dragElement.translatesAutoresizingMaskIntoConstraints = false
        return dragElement
    }()

    private lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: #selector(handlePan))
        return pan
    }()

    init() {
        let window = UIApplication.shared.keyWindow
        safeArea = window?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bottomSheetHeight = UIScreen.main.bounds.height - safeArea.top

        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(shadowView)
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        topConstraint = contentView.topAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        topConstraint.priority = UILayoutPriority(rawValue: 750)

        addSubview(contentView)
        NSLayoutConstraint.activate([
            topConstraint,
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor)
        ])

        contentView.addGestureRecognizer(panGesture)

        contentView.addSubview(dragElement)
        NSLayoutConstraint.activate([
            dragElement.topAnchor.constraint(equalTo: contentView.topAnchor),
            dragElement.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    func setContent(content: UIView) {
        contentView.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false

        content.layer.cornerRadius = Metrics.cornerRadius
        content.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        content.clipsToBounds = true

        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: dragElement.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func animateBottomSheet() {
        UIView.animate(withDuration: Metrics.animationDuration, animations: {
            self.topConstraint.constant = -self.bottomSheetHeight
            self.shadowView.alpha = Metrics.shadowViewAlpha
            self.layoutIfNeeded()
        })
    }

    func hideBottomSheet(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: Metrics.animationDuration, animations: {
            self.topConstraint.constant = 0
            self.shadowView.alpha = 0
            self.layoutIfNeeded()
        }, completion: { [unowned self] _ in
            self.delegate?.onBottomSheetClosed(completion: completion)
        })
    }

    // MARK: - Gesture actions

    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: contentView)
        let yTranslationMagnitude = translation.y.magnitude

        switch sender.state {
        case .changed:
            guard translation.y > 0 else { return }
            topConstraint.constant = yTranslationMagnitude - bottomSheetHeight
            layoutIfNeeded()
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
    static let dragElementHeight: CGFloat = 24
    static let shadowViewAlpha: CGFloat = 0.6
}
