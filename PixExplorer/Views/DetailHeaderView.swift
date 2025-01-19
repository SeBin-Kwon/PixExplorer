//
//  DetailHeaderView.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/20/25.
//

import UIKit

class DetailHeaderView: BaseView {
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .systemGray6
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    let nameLabel = {
        let label = UILabel()
        label.text = "abc"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let dateLabel = {
        let label = UILabel()
        label.text = "00년 게시됨"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.size.equalTo(30)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
        }
    }
    
}
