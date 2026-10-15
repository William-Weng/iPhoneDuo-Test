//
//  InnerPortraitViewController.swift
//  Example
//
//  Created by William.Weng on 2026/10/14.
//

import UIKit

final class InnerPortraitViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
}

extension InnerPortraitViewController: DuoDelegate {
    
    func updateLabel(with text: String) {
        label.text = text
    }
}
