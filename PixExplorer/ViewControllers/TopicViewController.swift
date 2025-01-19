//
//  TopicViewController.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import UIKit
import Kingfisher
import SnapKit

class TopicViewController: BaseViewController {
    
    let topicView = TopicView()
    private var goldenList = [Photo]()
    private var architectList = [Photo]()
    private var businessList = [Photo]()
    
    private lazy var scrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(topicView)
        configureLayout()
    }

    private func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        topicView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
    }
    
    override func configureView() {
        navigationItem.title = "OUR TOPIC"

        topicView.goldenCollectionView.delegate = self
        topicView.goldenCollectionView.dataSource = self
        topicView.architectCollectionView.delegate = self
        topicView.architectCollectionView.dataSource = self
        topicView.businessCollectionView.delegate = self
        topicView.businessCollectionView.dataSource = self
        
        topicView.goldenCollectionView.register(GoldenCollectionViewCell.self, forCellWithReuseIdentifier: GoldenCollectionViewCell.identifier)
        topicView.architectCollectionView.register(ArchitectCollectionViewCell.self, forCellWithReuseIdentifier: ArchitectCollectionViewCell.identifier)
        topicView.businessCollectionView.register(BusinessCollectionViewCell.self, forCellWithReuseIdentifier: BusinessCollectionViewCell.identifier)
        callRequest()
    }
    
    
    private func callRequest() {
        print(#function)
        let keyword = ["golden-hour", "architecture-interior", "business-work"]
        for i in 0..<keyword.count {
            NetworkManager.shared.fetchPhotoTopicResults(keyword[i]) { value in
                guard let value else { return }
                switch i {
                case 0:
                    self.goldenList = value
                case 1:
                    self.architectList = value
                default:
                    self.businessList = value
                }
            }
        }
    }
}

extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        switch collectionView {
        case topicView.goldenCollectionView:
            vc.id = goldenList[indexPath.item].id
            vc.urlString = goldenList[indexPath.item].urls.small
        case topicView.architectCollectionView:
            vc.id = architectList[indexPath.item].id
            vc.urlString = architectList[indexPath.item].urls.small
        default:
            vc.id = businessList[indexPath.item].id
            vc.urlString = businessList[indexPath.item].urls.small
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case topicView.goldenCollectionView:
            guard let cell = topicView.goldenCollectionView.dequeueReusableCell(withReuseIdentifier: GoldenCollectionViewCell.identifier, for: indexPath) as? GoldenCollectionViewCell else { return UICollectionViewCell() }
            cell.configureData(item: goldenList[indexPath.item])
            return cell
        case topicView.architectCollectionView:
            guard let cell = topicView.architectCollectionView.dequeueReusableCell(withReuseIdentifier: ArchitectCollectionViewCell.identifier, for: indexPath) as? ArchitectCollectionViewCell else { return UICollectionViewCell() }
            cell.configureData(item: architectList[indexPath.item])
            return cell
        default:
            guard let cell = topicView.businessCollectionView.dequeueReusableCell(withReuseIdentifier: BusinessCollectionViewCell.identifier, for: indexPath) as? BusinessCollectionViewCell else { return UICollectionViewCell() }
            cell.configureData(item: businessList[indexPath.item])
            return cell
        }
    }
    
    
}
