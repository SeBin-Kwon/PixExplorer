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
    
    override func loadView() {
        view = searchView
    }
    
    override func configureView() {
        navigationItem.title = "SEARCH PHOTO"
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        callRequest()
    }
    
    func callRequest() {
        NetworkManager.shard.callRequest("cat", 1) { value in
            print(#function)
            guard let value else { return }
            self.list = value.results
            self.searchView.collectionView.reloadData()
            print("전체 검색 수", value.total)
            print("총 페이지 수", value.total_pages)
        }
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
