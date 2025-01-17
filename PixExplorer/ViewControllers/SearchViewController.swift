//
//  SearchViewController.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import UIKit

class SearchViewController: BaseViewController {
    
    private let searchView = SearchView()
    
    override func loadView() {
        view = searchView
    }
    
    override func configureView() {
        navigationItem.title = "SEARCH PHOTO"
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
