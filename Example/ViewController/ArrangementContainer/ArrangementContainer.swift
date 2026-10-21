//
//  ArrangementContainer.swift
//  Example
//
//  Created by William.Weng on 2026/10/20.
//

import UIKit
import WWInterfaceOrientationCoordinator

@available(iOS 27.1, *)
final class ArrangementContainer: UIViewController {
    
    fileprivate enum SplitArrangementStyle {
        case general(style: UISplitArrangement)
        case custom(axis: UIAxis, preferred: UISplitArrangement.Dimension, placement: UIArrangementViewController.ViewPlacement)
    }
    
    private lazy var primaryViewController = PrimaryViewController.instantiate()
    private lazy var secondaryViewController = SecondaryViewController.instantiate()

    private let arrangementVC = UIArrangementViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        initDuoViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerOrientationCallback()
    }
    
    func registerOrientationCallback() {
        
        if let duo = navigationController as? DuoNavigationController {
            
            duo.callback = { [weak self] info in
                guard let self else { return }
                self.updateRatio(for: info)
            }
        }
    }
}

@available(iOS 27.1, *)
private extension ArrangementContainer {
    
    func initDuoViews() {
        
        let primaryVC = primaryViewController
        let secondaryVC = secondaryViewController
        
        arrangementVC.setViewController(primaryVC, for: .primary)
        arrangementVC.setViewController(secondaryVC, for: .secondary)
        
        addChild(arrangementVC)
        view.addSubview(arrangementVC.view)
        
        arrangementVC.view.frame = view.bounds
        arrangementVC.didMove(toParent: self)
        arrangementVC.updateArrangement(.overlay)
    }
    
    func updateRatio(for info: WWLayoutEnvironmentInformation) {
        
        let arrangement: UISplitArrangement
        
        if info.isRegularWidth, info.isLandscape {
            let range = WWInterfaceOrientationCoordinator.crossAxisDimensionRange(with: view.frame.size, ratio: .widthFollowsHeight(390 / 844))
            arrangement = splitArrangement(style: .custom(axis: .horizontal, preferred: try! range.get().preferred, placement: .primary))
            arrangementVC.updateArrangement(arrangement)
        } else {
            arrangementVC.updateArrangement(.overlay)
        }
    }
    
    func splitArrangement(style: SplitArrangementStyle) -> UISplitArrangement  {
        
        switch style {
        case .general(let style): return style
        case .custom(let axis, let preferred, let placement):
            
            var arrangement = UISplitArrangement.split.axes(axis)
            var properties = arrangement.defaultViewProperties
            
            properties.width.preferred = preferred
            properties.height.preferred = preferred
            
            arrangement.setViewProperties(properties, for: placement)
            
            return arrangement
        }
    }
}

