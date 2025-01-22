//
//  ColorButton.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/20/25.
//

import UIKit

final class ColorButton: UIButton {
    let color: Color
    init(frame: CGRect, color: Color) {
        self.color = color
        super.init(frame: .zero)
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.baseBackgroundColor = .systemGray6
        buttonConfig.baseForegroundColor = .black
        buttonConfig.image = UIImage(systemName: "circle.fill")
        buttonConfig.buttonSize = .small
        buttonConfig.imagePadding = 6
        buttonConfig.imagePlacement = .leading
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8)
        buttonConfig.cornerStyle = .capsule
        buttonConfig.imageColorTransformer = UIConfigurationColorTransformer {
            _ in UIColor.init(hexCode: color.value)
        }
        self.configuration = buttonConfig
    }
    
//    func isSelectedButton(_ isSelected: Bool) {
//        self.configuration?.baseForegroundColor = isSelected ? .white : . black
//        self.configuration?.baseBackgroundColor = isSelected ? .systemBlue : .systemGray6
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
