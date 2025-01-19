//
//  StarLabel.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import UIKit
import SnapKit

class StarLabel: BaseView {
    
    let backgroundView = {
        let bg = UIView()
        bg.backgroundColor = .darkGray
        bg.clipsToBounds = true
        bg.layer.cornerRadius = 10
        return bg
    }()
    
    let starLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        
        label.layer.cornerRadius = 10
        
        label.textAlignment = .center
        return label
    }()
    
    let starImage = {
        let image = UIImageView()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 8)
        image.image = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        image.tintColor = .yellow
        return image
    }()

    
    override func configureHierarchy() {
        addSubview(backgroundView)
        addSubview(starImage)
        addSubview(starLabel)
    }
    override func configureLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(20)
        }
        starImage.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundView)
            make.leading.equalTo(backgroundView).offset(10)
            make.trailing.equalTo(starLabel.snp.leading).offset(-5)
        }
        starLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundView)
            make.trailing.equalTo(backgroundView).offset(-10)
        }
    }

}
