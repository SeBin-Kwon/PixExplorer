//
//  NumberFormattedManager.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/19/25.
//

import Foundation

class NumberFormattedManager {
    
    static let shared = NumberFormattedManager()
    private let formatter = NumberFormatter()
    
    private init() {
        formatter.numberStyle = .decimal
    }
    
    func formatNumber(_ number: Int) -> String? {
        return formatter.string(from: number as NSNumber)
    }
}
