//
//  SearchView.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let searchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        return search
    }()
    let resultLabel = {
        let label = UILabel()
        label.text = "사진을 검색해보세요."
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.isHidden = false
        return label
    }()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(collectionView)
        addSubview(resultLabel)
    }
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar).offset(80)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        resultLabel.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
//        collectionView.backgroundColor = .yellow
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 5
        let lineSpacing: CGFloat = 5
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth-itemSpacing-40)/2
        print(width)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: width, height: width+(width/3))
        layout.scrollDirection = .vertical
        return layout
    }
}
