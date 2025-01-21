//
//  UIViewController+Extension.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        String(describing: self)
    }
    
    func displayAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
