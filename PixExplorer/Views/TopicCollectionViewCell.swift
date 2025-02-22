//
//  GoldenCollectionViewCell.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import UIKit

final class TopicCollectionViewCell: BaseCollectionViewCell {
    private let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.backgroundColor = .systemGray6
        return image
    }()
    private let starLabel = StarLabel()
    
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
