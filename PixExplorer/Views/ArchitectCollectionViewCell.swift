//
//  ArchitectCollectionViewCell.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import UIKit

class ArchitectCollectionViewCell: BaseCollectionViewCell {
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .red
        return image
    }()
    
    override func configureHierarchy() {
        addSubview(imageView)
//        addSubview(starLabel)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        starLabel.snp.makeConstraints { make in
//            make.leading.bottom.equalToSuperview().inset(20)
//        }
    }
    
    func configureData(item: Photo) {
        guard let url = URL(string: item.urls.small) else { return }
        imageView.kf.setImage(with: url)
//        starLabel.text = NumberFormattedManager.shared.formatNumber(item.likes)
    }
}
