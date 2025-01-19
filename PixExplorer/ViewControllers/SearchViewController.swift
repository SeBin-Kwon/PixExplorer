//
//  SearchViewController.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import UIKit

class SearchViewController: BaseViewController {
    
    private let searchView = SearchView()
    private var list = [Photo]()
    private var page = 1
    private var isEnd = false
    private var searchText: String?
    private var previousSearchText: String?
    private var isLatest = false
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SEARCH PHOTO"
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.prefetchDataSource = self
        searchView.searchBar.delegate = self
        searchView.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        guard let searchText else { return }
        callRequest(query: searchText, page: page, order: isLatest)
    }
    
    override func viewDidLayoutSubviews() {
        searchView.orderButton.layer.cornerRadius = searchView.orderButton.frame.height / 2
    }
    
    override func configureView() {
        searchView.orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    }
    
    @objc func orderButtonTapped() {
        print(#function)
        guard let searchText else { return }
        guard searchText.count != 0 else { return }
        isLatest.toggle()
        searchView.orderButton.setTitle(isLatest ? "최신순" : "관련순", for: .normal)
        page = 1
        callRequest(query: searchText, page: page, order: isLatest)
    }
    
    func callRequest(query: String, page: Int, order: Bool) {
        NetworkManager.shared.fetchPhotoSearchResults(query, page, order) { value in
            print(#function, "page:", page)
            print("islatest",order)
            guard let value else { return }
            if page == 1 {
                self.list = value.results
            } else {
                self.list.append(contentsOf: value.results)
            }
            if value.total == page {
                self.isEnd = true
            }
            if !self.list.isEmpty {
                self.searchView.resultLabel.isHidden = true
            } else if self.list.isEmpty {
                self.searchView.resultLabel.isHidden = false
                self.searchView.resultLabel.text = "검색 결과가 없습니다."
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

// MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchView.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        view.endEditing(true)
        if let previousSearchText {
            guard searchText != previousSearchText else { return }
        }
        page = 1
        isEnd = false
        previousSearchText = searchText
        self.searchText = searchText
        callRequest(query: searchText, page: page, order: isLatest)
    }
}



// MARK: Pagenation - UICollectionViewDataSourcePrefetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            if !isEnd && list.count-2 == indexPath.item || list.count-3 == indexPath.item {
                page += 1
                guard let searchText else { return }
                callRequest(query: searchText, page: page, order: isLatest)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print(#function)
    }
}


// MARK: UICollectionViewDelegate, DataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.id = list[indexPath.item].id
        vc.urlString = list[indexPath.item].urls.small
        vc.name = list[indexPath.item].user.name
        vc.profileUrl = list[indexPath.item].user.profile_image.small
        vc.createdDate = list[indexPath.item].created_at
        vc.width = list[indexPath.item].width
        vc.height = list[indexPath.item].height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchView.collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.configureData(item: list[indexPath.item])
        return cell
    }
}
