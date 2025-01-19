//
//  DetailViewController.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: BaseViewController {
    
    var id: String?
    var urlString: String?
    var name: String?
    var profileUrl: String?
    var createdDate: String?
    
    let detailView = DetailView()
    override func loadView() {
        view = detailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let id else { return }
        callRequest(id)
        guard let url = URL(string: urlString ?? "") else { return }
        detailView.imageView.kf.setImage(with: url)
        detailView.detailHeaderView.nameLabel.text = name
        detailView.detailHeaderView.dateLabel.text = DateFormattedManager.shared.dateFormetted(createdDate ?? "")
        guard let url = URL(string: profileUrl ?? "") else { return }
        detailView.detailHeaderView.imageView.kf.setImage(with: url)
    }
    
    private func callRequest(_ id: String) {
        print(#function)
        NetworkManager.shared.fetchPhotoDetailResults(id) { value in
            guard let value else { return }
            self.detailView.downloadDataLabel.text = NumberFormattedManager.shared.formatNumber(value.downloads.total)
            self.detailView.viewDataLabel.text = NumberFormattedManager.shared.formatNumber(value.views.total)
        }
    }
    
    override func configureView() {
        navigationItem.largeTitleDisplayMode = .never
    }
}
