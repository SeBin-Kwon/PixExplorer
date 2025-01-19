//
//  DateFormattedManager.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/20/25.
//

import Foundation

class DateFormattedManager {
    static let shared = DateFormattedManager()
    private init() {}
    
    func dateFormetted(_ str: String) -> String {
        let format = DateFormatter()
        let date = format.date(from: str)
        format.locale = Locale(identifier: "ko_KR")
        format.dateFormat = "yyyy년 M월 d일 게시됨"
        return format.string(from: date ?? Date())
    }
}
