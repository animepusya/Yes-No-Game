//
//  Model.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import Foundation

struct Card: Identifiable, Codable, Hashable {
    let id: Int
    let category: String
    let title: String
    let description: String
    let hint: String
    let explanation: String
    let imageName: String?
    let imageUrl: String?
}

enum Category: String, CaseIterable {
    case military = "Military"
    case horror = "Horror"
    case films = "Films"
    case cartoons = "Cartoons"
    case anime = "Anime"
    case ordinary = "Ordinary"
    
    var title: String {
        switch self {
        case .military: return "Военные"
        case .horror: return "Ужасы"
        case .films: return "Фильмы"
        case .cartoons: return "Мультики"
        case .anime: return "Аниме"
        case .ordinary: return "Повседневные"
        }
    }
}
