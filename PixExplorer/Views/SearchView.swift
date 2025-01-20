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
    
    let orderButton: UIButton = {
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.title = "관련순"
        buttonConfig.baseBackgroundColor = .white
        buttonConfig.baseForegroundColor = .black
        buttonConfig.image = UIImage(systemName: "list.triangle")
        buttonConfig.buttonSize = .small
        buttonConfig.imagePadding = 10
        buttonConfig.imagePlacement = .leading
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 13, bottom: 8, trailing: 30)
        let btn = UIButton(configuration: buttonConfig)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
        return btn
    }()
    
    let colorButtonStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    let scrollView = {
       let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 110)
        return scroll
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(collectionView)
        addSubview(resultLabel)
        addSubview(scrollView)
        scrollView.addSubview(colorButtonStackView)
        addSubview(orderButton)
    }
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(orderButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        resultLabel.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        colorButtonStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(scrollView)
            make.height.equalTo(scrollView.snp.height)
        }
        orderButton.snp.makeConstraints { make in
            make.centerY.equalTo(scrollView)
            make.trailing.equalTo(safeAreaInsets).offset(18)
        }
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 5
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth-itemSpacing)/2
        print(width)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: width+(width/3))
        layout.scrollDirection = .vertical
        return layout
    }
}
