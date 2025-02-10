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
    
    let detailView = DetailView()
    let viewModel = DetailViewModel()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    private func bindData() {
        viewModel.output.photo.lazyBind { [weak self] photo in
            print("output photo lazybind")
            self?.detailView.photo = photo
        }
        viewModel.output.profileName.lazyBind { [weak self] text in
            self?.detailView.detailHeaderView.nameLabel.text = text
        }
        viewModel.output.profileURL.lazyBind { [weak self] url in
            self?.detailView.detailHeaderView.imageView.kf.setImage(with: url)
        }
        viewModel.output.photoDate.lazyBind { [weak self] text in
            self?.detailView.detailHeaderView.dateLabel.text = text
        }
        viewModel.output.photoURL.lazyBind { [weak self] url in
            self?.detailView.imageView.kf.setImage(with: url)
        }
        viewModel.output.photoSize.lazyBind { [weak self] text in
            self?.detailView.sizeDataLabel.text = text
        }
        viewModel.output.photoDownloads.lazyBind { [weak self] text in
            self?.detailView.downloadDataLabel.text = text
        }
        viewModel.output.photoViews.lazyBind { [weak self] text in
            self?.detailView.viewDataLabel.text = text
        }   
    }
    
    override func configureView() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
}
