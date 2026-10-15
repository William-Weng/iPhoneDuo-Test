//
//  DuoDelegate.swift
//  Example
//
//  Created by William.Weng on 2026/10/14.
//

import UIKit

/// Duo 畫面子頁面的 delegate protocol
protocol DuoDelegate: UIViewController {
    
    /// 以指定的文字更新標籤
    ///
    /// - Parameter text: 要顯示在標籤上的文字
    func updateLabel(with text: String)
}
