//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2026/10/14.
//

import UIKit
import WWInterfaceOrientationCoordinator

final class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerOrientationCallback()
    }
}

// MARK: - Private
private extension ViewController {
    
    /// 向所屬的 DuoNavigationController 註冊方向變化 callback
    func registerOrientationCallback() {
        
        if let duo = navigationController as? DuoNavigationController {
            
            updateLayout(info: duo.orientationInformation)
            
            duo.callback = { [weak self] info in
                guard let self else { return }
                self.updateLayout(info: info)
            }
        }
    }
    
    /// 依 horizontal size class 與 interface orientation 更新圖片
    ///
    /// - Parameter info: 由 DuoNavigationController 提供的方向資訊
    func updateLayout(info: WWLayoutEnvironmentInformation) {

        switch (info.isRegularWidth , info.isPortrait) {
        case (false, true): imageView.image = .outterPortrait       // Compact width + Portrait
        case (false, false): imageView.image = .outterLandscape     // Compact width + Landscape
        case (true, true): imageView.image = .innerPortrait         // Regular width + Portrait
        case (true, false): imageView.image = .innerLandscape       // Regular width + Landscape
        }
    }
}
