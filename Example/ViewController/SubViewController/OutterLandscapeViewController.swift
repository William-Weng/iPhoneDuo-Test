//
//  OutterLandscapeViewController.swift
//  Example
//
//  Created by William.Weng on 2026/10/14.
//

import UIKit

final class OutterLandscapeViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
}

extension OutterLandscapeViewController: DuoDelegate {
    
    func updateLabel(with text: String) {
        label.text = text
    }
}
