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
    
    private var topicList: [[TopicType:[Photo]]] = [[:], [:], [:]]
    private var isEndRequest = false
    
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
    
    enum TopicType: String, CaseIterable {
        case goldenHour = "golden-hour"
        case architectureInterior = "architecture-interior"
        case businessWork = "business-work"
    }
    
    override func configureView() {
        navigationItem.title = "OUR TOPIC"

        topicView.goldenCollectionView.delegate = self
        topicView.goldenCollectionView.dataSource = self
        topicView.architectCollectionView.delegate = self
        topicView.architectCollectionView.dataSource = self
        topicView.businessCollectionView.delegate = self
        topicView.businessCollectionView.dataSource = self
        
        topicView.goldenCollectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.identifier)
        topicView.architectCollectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.identifier)
        topicView.businessCollectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.identifier)
        callRequest()
    }
    
    
    private func callRequest() {
        print(#function)
        let keyword = ["golden-hour", "architecture-interior", "business-work"]
        let group = DispatchGroup()
        for i in 0..<TopicType.allCases.count {
            group.enter()
            NetworkManager.shared.fetchPhotoTopicResults(api: .topic(value: TopicRequest(topic: keyword[i], page: 1))) { value in
                switch i {
                case 0:
                    self.goldenList = value
                case 1:
                    self.architectList = value
                default:
                    self.businessList = value
                }
                group.leave()
            } failHandler: { error in
                self.displayAlert(title: error.localizedDescription)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            print(#function, "---END---")
            self.isEndRequest = true
            self.topicView.goldenCollectionView.reloadData()
            self.topicView.architectCollectionView.reloadData()
            self.topicView.businessCollectionView.reloadData()
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
            vc.photo = goldenList[indexPath.item]
            vc.detailView.photo = goldenList[indexPath.item]
        case topicView.architectCollectionView:
            vc.photo = architectList[indexPath.item]
            vc.detailView.photo = architectList[indexPath.item]
        default:
            vc.photo = businessList[indexPath.item]
            vc.detailView.photo = businessList[indexPath.item]
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case topicView.goldenCollectionView:
            guard let cell = topicView.goldenCollectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            guard isEndRequest else { return cell }
            cell.configureData(item: goldenList[indexPath.item])
            return cell
        case topicView.architectCollectionView:
            guard let cell = topicView.architectCollectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            guard isEndRequest else { return cell }
            cell.configureData(item: architectList[indexPath.item])
            return cell
        default:
            guard let cell = topicView.businessCollectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            guard isEndRequest else { return cell }
            cell.configureData(item: businessList[indexPath.item])
            return cell
        }
    }
    
    
}
