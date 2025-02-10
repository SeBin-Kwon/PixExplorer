//
//  TopicViewController.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import UIKit
import Kingfisher
import SnapKit

final class TopicViewController: BaseViewController {
    
    private let topicView = TopicView()
    private var topicDict = [Topic:[Photo]]()
    private let refreshControl = UIRefreshControl()
    
    private lazy var scrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, self)
        view.addSubview(scrollView)
        scrollView.addSubview(topicView)
        configureLayout()
//        initRefresh()
    }
    
    func initRefresh() {
        print(#function)
        refreshControl.backgroundColor = .yellow
        refreshControl.tintColor = .purple
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(refresh:)), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    @objc func refreshCollectionView(refresh: UIRefreshControl) {
        print("새로고침 시작")
//        topicView.topicResultList = Array(Topic.allCases.shuffled()[0..<3])
//        callRequest(topicView.topicResultList)
        refresh.endRefreshing()
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
        print(#function, self)
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
            NetworkManager.shared.fetchPhotoResults(api: .topic(value: TopicRequest(topic: element.rawValue, page: 1)), type: [Photo].self) { value in
                self.topicDict[element] = value
                group.leave()
            } failHandler: { code, error in
                self.displayAlert(title: "\(String(code)): \(error.title)", message: error.reason)
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
        vc.viewModel.input.photo.value = photoList[indexPath.item]
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

