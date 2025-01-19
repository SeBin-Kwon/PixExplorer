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
    
    lazy var goldenCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    lazy var architectCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    lazy var businessCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .yellow
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
    override func configureView() {
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 5
        let lineSpacing: CGFloat = 5
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 200, height: 300)
        layout.scrollDirection = .horizontal
        return layout
    }
}
