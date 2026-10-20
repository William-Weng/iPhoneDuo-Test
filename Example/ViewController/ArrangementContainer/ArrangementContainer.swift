//
//  ArrangementContainer.swift
//  Example
//
//  Created by William.Weng on 2026/10/20.
//

import UIKit

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
        
        let primaryVC = primaryViewController
        let secondaryVC = secondaryViewController
        let arrangement = splitArrangement(style: .custom(axis: .horizontal, preferred: .fractional(0.3), placement: .primary))
        
        arrangementVC.setViewController(primaryVC, for: .primary)
        arrangementVC.setViewController(secondaryVC, for: .secondary)
        arrangementVC.updateArrangement(arrangement)
        
        addChild(arrangementVC)
        view.addSubview(arrangementVC.view)
        arrangementVC.view.frame = view.bounds
        arrangementVC.didMove(toParent: self)
    }
}

@available(iOS 27.1, *)
private extension ArrangementContainer {
    
    func splitArrangement(style: SplitArrangementStyle) -> UISplitArrangement  {
        
        switch style {
        case .general(let style): return style
        case .custom(let axis, let preferred, let placement):
            
            var arrangement = UISplitArrangement.split.axes(axis)
            var properties = arrangement.defaultViewProperties
            
            properties.width.preferred = preferred
            arrangement.setViewProperties(properties, for: placement)
            
            return arrangement
        }
    }
}
