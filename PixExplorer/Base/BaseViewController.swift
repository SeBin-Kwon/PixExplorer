//
//  BaseViewController.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import UIKit

class BaseViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        configureView()
    }
    
    func configureView() {
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
