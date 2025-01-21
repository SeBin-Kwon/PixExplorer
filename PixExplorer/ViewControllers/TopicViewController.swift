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
    
    private let topicView = TopicView()
    private var topicDict = [Topic:[Photo]]()
    
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
        topicView.collectionViewList.enumerated().forEach {
            $1.delegate = self
            $1.dataSource = self
            $1.tag = $0
            $1.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.identifier)
        }
        callRequest(topicView.topicResultList)
    }
    
    
    private func callRequest(_ list: [Topic]) {
        print(#function)
        let group = DispatchGroup()
        for element in list {
            group.enter()
            NetworkManager.shared.fetchPhotoTopicResults(api: .topic(value: TopicRequest(topic: element.rawValue, page: 1))) { value in
                self.topicDict[element] = value
                group.leave()
            } failHandler: { error in
                self.displayAlert(title: error.localizedDescription)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            print(#function, "-END-")
            self.topicView.collectionViewList.forEach {
                $0.reloadData()
            }
        }
    }
}

extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        guard let photoList = topicDict[topicView.topicResultList[collectionView.tag]] else { return }
        vc.photo = photoList[indexPath.item]
        vc.detailView.photo = photoList[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = topicView.collectionViewList[collectionView.tag].dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
        guard !topicDict.isEmpty else { return cell }
        guard let photoList = topicDict[topicView.topicResultList[collectionView.tag]] else { return cell }
        cell.configureData(item: photoList[indexPath.item])
        return cell
    }
}

