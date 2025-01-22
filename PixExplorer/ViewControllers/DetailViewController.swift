//
//  DetailViewController.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailViewController: BaseViewController {
    
    var photo: Photo?
    
    let detailView = DetailView()
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(detailView)
        configureLayout()
    }
    
    private func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        detailView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let photo else { return }
        callRequest(photo.id)
        guard let url = URL(string: photo.urls.small) else { return }
        detailView.imageView.kf.setImage(with: url)
        detailView.detailHeaderView.nameLabel.text = photo.user.name
        detailView.detailHeaderView.dateLabel.text = DateFormattedManager.shared.dateFormetted(photo.created_at)
        guard let url = URL(string: photo.user.profile_image.small) else { return }
        detailView.detailHeaderView.imageView.kf.setImage(with: url)
        detailView.sizeDataLabel.text = "\(photo.width) x \(photo.height)"
    }
    
    private func callRequest(_ id: String) {
        print(#function)
        guard let photo else { return }
        NetworkManager.shared.fetchPhotoResults(api: .detail(id: photo.id), type: PhotoDetail.self) { value in
            self.detailView.downloadDataLabel.text = NumberFormattedManager.shared.formatNumber(value.downloads.total)
            self.detailView.viewDataLabel.text = NumberFormattedManager.shared.formatNumber(value.views.total)
        } failHandler: { error in
            self.displayAlert(title: error.localizedDescription)
        }
    }
    
    override func configureView() {
        navigationItem.largeTitleDisplayMode = .never
    }
}
