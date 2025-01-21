//
//  Topic.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/21/25.
//

import Foundation

enum Topic: String, CaseIterable {
    case goldenHour = "golden-hour"
    case architectureInterior = "architecture-interior"
    case businessWork = "business-work"
    case wallpapers = "wallpapers"
    case nature = "nature"
    case _3dRenders = "3d-renders"
    case travel = "travel"
    case texturesPatterns = "textures-patterns"
    case streetPhotography = "street-photography"
    case film = "film"
    case archival = "archival"
    case experimental = "experimental"
    case animals = "animals"
    case fashionBeauty = "fashion-beauty"
    case people = "people"
    case foodDrink = "food-drink"
    
    var title: String {
        switch self {
        case .goldenHour: return "골든 아워"
        case .architectureInterior: return "건축 및 인테리어"
        case .businessWork: return "비즈니스 및 업무"
        case .wallpapers: return "배경 화면"
        case .nature: return "자연"
        case ._3dRenders: return "3D 렌더링"
        case .travel: return "여행하다"
        case .texturesPatterns: return "텍스쳐 및 패턴"
        case .streetPhotography: return "거리 사진"
        case .film: return "필름"
        case .archival: return "기록의"
        case .experimental: return "실험적인"
        case .animals: return "동물"
        case .fashionBeauty: return "패션 및 뷰티"
        case .people: return "사람"
        case .foodDrink: return "식음료"
        }
    }
}
