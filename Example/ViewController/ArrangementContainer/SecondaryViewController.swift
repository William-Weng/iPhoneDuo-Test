//
//  SecondaryViewController.swift
//  Example
//
//  Created by William.Weng on 2026/10/20.
//

import UIKit

final class SecondaryViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .arrangementBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: effect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }

    /// 可在 view 載入前或載入後更新背景圖片。
    func setBackgroundImage(_ image: UIImage?) {
        backgroundImageView.image = image
    }

    /// 切換系統模糊樣式。
    func setBlurStyle(_ style: UIBlurEffect.Style) {
        blurView.effect = UIBlurEffect(style: style)
    }
}

private extension SecondaryViewController {

    func setupBackground() {
        view.backgroundColor = .black

        // 純裝飾背景，不處理點擊。
        view.isUserInteractionEnabled = false
        view.accessibilityElementsHidden = true

        // 先放圖片，再放模糊層。
        view.addSubview(backgroundImageView)
        view.addSubview(blurView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),

            blurView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            blurView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            blurView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            blurView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }
}
