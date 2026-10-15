//
//  OutterPortraitViewController.swift
//  Example
//
//  Created by William.Weng on 2026/10/14.
//

import UIKit

final class OutterPortraitViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
}

extension OutterPortraitViewController: DuoDelegate {
    
    func updateLabel(with text: String) {
        label.text = text
    }
}
