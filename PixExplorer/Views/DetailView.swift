//
//  DetailView.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import UIKit
import SnapKit

final class DetailView: BaseView {
    
    var photoSize = (0, 0)
    let detailHeaderView = DetailHeaderView()
    private let scrollView = UIScrollView()
    
    let uiView = UIView()
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    private let infoLabel = {
        let label = UILabel()
        label.text = "정보"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    private let sizeLabel = {
        let label = UILabel()
        label.text = "크기"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    private let downloadLabel = {
        let label = UILabel()
        label.text = "다운로드"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    private let viewLabel = {
        let label = UILabel()
        label.text = "조회수"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    let sizeDataLabel = {
        let label = UILabel()
        label.text = "000 x 000"
        return label
    }()
    let downloadDataLabel = {
        let label = UILabel()
        label.text = "dsfdsf"
        return label
    }()
    let viewDataLabel = {
        let label = UILabel()
        label.text = "000000"
        return label
    }()
    
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(uiView)
        [detailHeaderView, imageView, infoLabel, sizeLabel, viewLabel, downloadLabel, sizeDataLabel, viewDataLabel, downloadDataLabel].forEach {
            uiView.addSubview($0)
        }
    }
    
    override func updateConstraints() {
        print(#function)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(detailHeaderView.snp.bottom)
            make.width.equalTo(uiView)
            make.height.equalTo(snp.width).multipliedBy(CGFloat(photoSize.1)/CGFloat(photoSize.0))
        }
        super.updateConstraints()
    }
        
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        uiView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }

        detailHeaderView.snp.makeConstraints { make in
            make.top.equalTo(uiView)
            make.horizontalEdges.equalTo(uiView)
            make.height.equalTo(50)
        }

        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(uiView).offset(10)
        }
        sizeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infoLabel)
            make.leading.equalTo(infoLabel.snp.trailing).offset(30)
        }
        viewLabel.snp.makeConstraints { make in
            make.top.equalTo(sizeLabel.snp.bottom).offset(10)
            make.leading.equalTo(infoLabel.snp.trailing).offset(30)
        }
        downloadLabel.snp.makeConstraints { make in
            make.top.equalTo(viewLabel.snp.bottom).offset(10)
            make.leading.equalTo(viewLabel)
        }
        sizeDataLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infoLabel)
            make.trailing.equalTo(uiView).inset(10)
        }
        viewDataLabel.snp.makeConstraints { make in
            make.top.equalTo(sizeDataLabel.snp.bottom).offset(10)
            make.trailing.equalTo(uiView).inset(10)
        }
        downloadDataLabel.snp.makeConstraints { make in
            make.top.equalTo(viewDataLabel.snp.bottom).offset(10)
            make.trailing.equalTo(uiView).inset(10)
            make.bottom.equalTo(uiView).inset(50)
        }
    }
}
