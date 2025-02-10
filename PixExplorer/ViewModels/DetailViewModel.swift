//
//  DetailViewModel.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 2/10/25.
//

import Foundation

protocol InOutProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform()
}

class DetailViewModel: InOutProtocol {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init() {
        transform()
    }
    
    func transform() {
        print(#function)
    }
    
}
