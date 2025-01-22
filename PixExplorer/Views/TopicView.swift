//
//  TopicView.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import UIKit

final class TopicView: BaseView {
    
    var topicResultList = Array(Topic.allCases.shuffled()[0..<3])
    private lazy var labelList = [UILabel]()
    lazy var collectionViewList = [UICollectionView]()

    private let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override func configureHierarchy() {
        for i in 0..<topicResultList.count {
            let label = configureLabel(text: topicResultList[i].title)
            let collection = configureCollectionView()
            labelList.append(label)
            collectionViewList.append(collection)
            addSubview(label)
            addSubview(collection)
        }
    }
    
    override func configureLayout() {
        labelList[0].snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        collectionViewList[0].snp.makeConstraints { make in
            make.top.equalTo(labelList[0].snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(300)
        }
        labelList[1].snp.makeConstraints { make in
            make.top.equalTo(collectionViewList[0].snp.bottom).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)
        }
        collectionViewList[1].snp.makeConstraints { make in
            make.top.equalTo(labelList[1].snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(300)
        }
        labelList[2].snp.makeConstraints { make in
            make.top.equalTo(collectionViewList[1].snp.bottom).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)
        }
        collectionViewList[2].snp.makeConstraints { make in
            make.top.equalTo(labelList[2].snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(300)
        }
    }
    
    private func configureLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }
    
    private func configureCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 10
        layout.minimumInteritemSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 200, height: 300)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        return view
    }
}
