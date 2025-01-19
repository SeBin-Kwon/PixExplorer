//
//  TopicView.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import UIKit

class TopicView: BaseView {
    
    let goldenLabel = {
        let label = UILabel()
        label.text = "골든 아워"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    let architectLabel = {
        let label = UILabel()
        label.text = "건축 및 인테리어"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    let businessLabel = {
        let label = UILabel()
        label.text = "비즈니스 및 업무"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    lazy var goldenCollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    lazy var architectCollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    lazy var businessCollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    
    override func configureHierarchy() {
        
        addSubview(goldenLabel)
        addSubview(goldenCollectionView)
        addSubview(architectLabel)
        addSubview(architectCollectionView)
        addSubview(businessLabel)
        addSubview(businessCollectionView)
    }
    override func configureLayout() {
        goldenLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        goldenCollectionView.snp.makeConstraints { make in
            make.top.equalTo(goldenLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(300)
        }
        architectLabel.snp.makeConstraints { make in
            make.top.equalTo(goldenCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)
        }
        architectCollectionView.snp.makeConstraints { make in
            make.top.equalTo(architectLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(300)
        }
        businessLabel.snp.makeConstraints { make in
            make.top.equalTo(architectCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)
        }
        businessCollectionView.snp.makeConstraints { make in
            make.top.equalTo(businessLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(300)
        }
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 10
        layout.minimumInteritemSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 200, height: 300)
        layout.scrollDirection = .horizontal
        return layout
    }
}
