//
//  DetailView.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import UIKit
import SnapKit

class DetailView: BaseView {
    
    let detailHeaderView = DetailHeaderView()
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    let infoLabel = {
        let label = UILabel()
        label.text = "정보"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    let sizeLabel = {
        let label = UILabel()
        label.text = "크기"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    let downloadLabel = {
        let label = UILabel()
        label.text = "다운로드"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    let viewLabel = {
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
        addSubview(detailHeaderView)
        addSubview(imageView)
        addSubview(infoLabel)
        addSubview(sizeLabel)
        addSubview(viewLabel)
        addSubview(downloadLabel)
        addSubview(sizeDataLabel)
        addSubview(viewDataLabel)
        addSubview(downloadDataLabel)
    }
    override func configureLayout() {
        detailHeaderView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(detailHeaderView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
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
            make.trailing.equalTo(safeAreaLayoutGuide).inset(10)
        }
        viewDataLabel.snp.makeConstraints { make in
            make.top.equalTo(sizeDataLabel.snp.bottom).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(10)
        }
        downloadDataLabel.snp.makeConstraints { make in
            make.top.equalTo(viewDataLabel.snp.bottom).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
}
