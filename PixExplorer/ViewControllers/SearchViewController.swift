//
//  SearchViewController.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import UIKit
import Alamofire

class SearchViewController: BaseViewController {
    
    private let searchView = SearchView()
    var list = [Photo]()
    var page = 1
    var isEnd = false
    
    override func loadView() {
        view = searchView
    }
    
    override func configureView() {
        navigationItem.title = "SEARCH PHOTO"
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.prefetchDataSource = self
        searchView.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        callRequest(page: page)
    }
    
    func callRequest(page: Int) {
        NetworkManager.shard.callRequest("cat", page) { value in
            print(#function, "page:", page)
            guard let value else { return }
            if page == 1 {
                self.list = value.results
            } else {
                self.list.append(contentsOf: value.results)
            }
            if value.total == page {
                self.isEnd = true
            }
            self.searchView.collectionView.reloadData()
            if page == 1 && !self.list.isEmpty {
                self.searchView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
            print("전체 검색 수", value.total)
            print("총 페이지 수", value.total_pages)
        }
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            if !isEnd && list.count-2 == indexPath.item {
                page += 1
                callRequest(page: page)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print(#function)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchView.collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.configureData(item: list[indexPath.item])
        return cell
    }
    
    
}
