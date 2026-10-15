//
//  InnerLandscapeViewController.swift
//  Example
//
//  Created by William.Weng on 2026/10/14.
//

import UIKit

final class InnerLandscapeViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
}

extension InnerLandscapeViewController: DuoDelegate {
    
    func updateLabel(with text: String) {
        label.text = text
    }
}
