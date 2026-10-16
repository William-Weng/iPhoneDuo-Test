//
//  DuoNavigationController.swift
//  Example
//
//  Created by William.Weng on 2026/10/14.
//

import UIKit
import WWInterfaceOrientationCoordinator

final class DuoNavigationController: UINavigationController {
    
    /// 目前最新的方向／horizontal size class 資訊
    var orientationInformation: WWLayoutEnvironmentInformation = .unknown
    
    /// 方向資訊更新時的 callback
    var callback: ((WWLayoutEnvironmentInformation) -> Void)?
    
    /// 方向協調器；綁定在 Navigation Controller 上，由它統一觀察旋轉、size class 與 transition
    private lazy var orientationCoordinator = WWInterfaceOrientationCoordinator(viewController: self)
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        registerOrientationCoordinator()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        willTransitionAction(coordinator: coordinator)
    }
}

// MARK: - Private
private extension DuoNavigationController {
        
    /// 註冊方向變化與初始資訊的 callback
    func registerOrientationCoordinator() {
        
        orientationCoordinator.register { [weak self] info in
            guard let self else { return }
            callbackAction(with: info)
        } onChange: { [weak self] info in
            guard let self else { return }
            callbackAction(with: info)
        }
    }
    
    /// 處理 view controller 尺寸／方向即將改變的事件
    ///
    /// - Parameter coordinator: UIKit 在 rotation／transition 時提供的 coordinator
    func willTransitionAction(coordinator: UIViewControllerTransitionCoordinator) {
        
        orientationCoordinator.willTransition(with: coordinator) { [weak self] info in
            guard let self else { return }
            callbackAction(with: info)
        }
    }
    
    /// 更新最新方向資訊，並通知目前有興趣的 child VC
    ///
    /// - Parameter info: 最新的方向與 horizontal size class 資訊
    func callbackAction(with info: WWLayoutEnvironmentInformation) {
        orientationInformation = info
        callback?(info)
    }
}
