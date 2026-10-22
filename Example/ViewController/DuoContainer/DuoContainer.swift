//
//  DuoContainer.swift
//  Example
//
//  Created by William.Weng on 2026/10/22.
//

import UIKit
import WWInterfaceOrientationCoordinator

final class DuoContainer: UIViewController {

    @IBOutlet weak var duoStackView: UIStackView!
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var subContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerOrientationCallback()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 27.1, *) {
            if let duo = navigationController as? DuoNavigationController, let region = duo.orientationCoordinator.activeDivisionRegion {
                duoStackView.spacing = region.frame.width
            } else {
                duoStackView.spacing = 0
            }
        }
    }
}

private extension DuoContainer {
    
    func registerOrientationCallback() {
        
        if let duo = navigationController as? DuoNavigationController {
                        
            if #available(iOS 27.1, *) {
                                
                if let region = duo.orientationCoordinator.activeDivisionRegion {
                    duoStackView.spacing = region.frame.width
                } else {
                    duoStackView.spacing = 0
                }
            }
            
            updateRatio(for: duo.layoutEnvironmentInformation)
            
            duo.callback = { [weak self] info in
                guard let self else { return }
                self.updateRatio(for: info)
            }
        }
    }
    
    func updateRatio(for info: WWLayoutEnvironmentInformation) {
        
        if info.isRegularWidth, info.isLandscape {
            subContainer.isHidden = false
        } else {
            subContainer.isHidden = true
        }
    }
}
