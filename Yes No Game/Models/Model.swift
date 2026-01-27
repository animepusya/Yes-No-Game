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

enum Category: String, CaseIterable, Hashable {
    case military = "Military"
    case horror = "Horror"
    case films = "Films"
    case cartoons = "Cartoons"
    case anime = "Anime"
    case ordinary = "Ordinary"
    case science = "Science"
    case travel = "Travel"

    var title: String {
            NSLocalizedString("category.\(rawValue.lowercased())", comment: "")
        }
}
