//
//  DuoViewController.swift
//  Example
//
//  Created by William.Weng on 2026/10/14.
//

import UIKit
import WWInterfaceOrientationCoordinator

final class DuoViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    /// 目前顯示中的 child view controller
    private var currentViewController: DuoDelegate?
    
    /// 四種版型的 child VC；只建立一次，旋轉時重複使用
    private lazy var outterPortraitViewController = OutterPortraitViewController(nibName: "OutterPortraitViewController", bundle: nil)
    private lazy var outterLandscapeViewController = OutterLandscapeViewController(nibName: "OutterLandscapeViewController", bundle: nil)
    private lazy var innerPortraitViewController = InnerPortraitViewController(nibName: "InnerPortraitViewController", bundle: nil)
    private lazy var innerLandscapeViewController = InnerLandscapeViewController(nibName: "InnerLandscapeViewController", bundle: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerOrientationCallback()
    }
}

// MARK: - Private
private extension DuoViewController {
    
    /// 向所屬的 DuoNavigationController 註冊方向變化 callback
    func registerOrientationCallback() {
        
        if let duo = navigationController as? DuoNavigationController {
            
            chanageViewController(with: duo.orientationInformation)
            
            duo.callback = { [weak self] info in
                guard let self else { return }
                self.chanageViewController(with: info)
            }
        }
    }
    
    /// 依 horizontal size class 與 interface orientation 選擇對應的 child VC
    ///
    /// - Parameter info: 由 DuoNavigationController 提供的方向資訊
    func chanageViewController(with info: WWOrientationInformation) {
        
        let nextViewController: DuoDelegate
        
        switch (info.isRegularWidth , info.isPortrait) {
        case (false, true): nextViewController = outterPortraitViewController
        case (false, false): nextViewController = outterLandscapeViewController
        case (true, true): nextViewController = innerPortraitViewController
        case (true, false): nextViewController = innerLandscapeViewController
        }
        
        nextViewController.loadViewIfNeeded()
        nextViewController.updateLabel(with: Date.now.ISO8601Format())
        
        guard nextViewController !== currentViewController else { nextViewController.updateLabel(with: Date.now.ISO8601Format()); return }
        changeContainerView(at: containerView, from: currentViewController, to: nextViewController)
        currentViewController = nextViewController
    }
}
