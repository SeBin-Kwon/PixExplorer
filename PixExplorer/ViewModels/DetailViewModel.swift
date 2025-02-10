//
//  DetailViewModel.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 2/10/25.
//

import Foundation

class DetailViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        var photo: Observable<Photo?> = Observable(nil)
    }
    
    struct Output {
        var photo: Observable<Photo?> = Observable(nil)
        var profileURL: Observable<URL?> = Observable(nil)
        var profileName: Observable<String?> = Observable(nil)
        var photoDate: Observable<String?> = Observable(nil)
        var photoURL: Observable<URL?> = Observable(nil)
        var photoSize: Observable<String?> = Observable(nil)
        var photoDownloads: Observable<String?> = Observable(nil)
        var photoViews: Observable<String?> = Observable(nil)
        
    }
    
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        print(#function)
        input.photo.lazyBind { [weak self] value in
            guard let value else { return }
            self?.output.photo.value = value
            self?.output.profileURL.value = URL(string: value.user.profile_image.small)
            self?.output.profileName.value = value.user.name
            self?.output.photoDate.value = DateFormattedManager.shared.dateFormetted(value.created_at)
            self?.output.photoURL.value = URL(string: value.urls.small)
            self?.output.photoSize.value = "\(value.width) x \(value.height)"
            self?.callRequest(value.id)
        }
    }
    
    private func callRequest(_ id: String) {
        print(#function)
        NetworkManager.shared.fetchPhotoResults(api: .detail(id: id), type: PhotoDetail.self) { [weak self] value in
            
            self?.output.photoDownloads.value = NumberFormattedManager.shared.formatNumber(value.downloads.total)
            self?.output.photoViews.value = NumberFormattedManager.shared.formatNumber(value.views.total)

        } failHandler: { code, error in
            print(error)
//            self.displayAlert(title: "\(String(code)): \(error.rawValue)", message: error.reason)
        }
    }
    
}
