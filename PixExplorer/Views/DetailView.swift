//
//  DetailView.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import UIKit
import SnapKit

class DetailView: BaseView {
    
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
        addSubview(imageView)
        addSubview(infoLabel)
        addSubview(downloadLabel)
        addSubview(viewLabel)
        addSubview(downloadDataLabel)
        addSubview(viewDataLabel)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
        }
        viewLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(infoLabel.snp.trailing).offset(30)
        }
        downloadLabel.snp.makeConstraints { make in
            make.top.equalTo(viewLabel.snp.bottom).offset(10)
            make.leading.equalTo(viewLabel)
        }
        viewDataLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(10)
        }
        downloadDataLabel.snp.makeConstraints { make in
            make.top.equalTo(viewDataLabel.snp.bottom).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configureView() {
        
    }
    
}
