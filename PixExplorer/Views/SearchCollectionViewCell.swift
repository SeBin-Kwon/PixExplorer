//
//  SearchCollectionViewCell.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import UIKit
import Kingfisher
import SnapKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .systemGray6
        image.clipsToBounds = true
        return image
    }()
    
    let starLabel = StarLabel()
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(starLabel)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        starLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configureData(item: Photo) {
        guard let url = URL(string: item.urls.small) else { return }
        imageView.kf.setImage(with: url)
        starLabel.starLabel.text = NumberFormattedManager.shared.formatNumber(item.likes)
    }
}
