//
//  BaseView.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
