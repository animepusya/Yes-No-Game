//
//  Model.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 26.07.2025.
//

import Foundation

struct Card: Identifiable, Codable {
    var id = UUID()
    let category: String
    let title: String
    let description: String
    let hint: String
    let explanation: String
    let imageName: String
    
    enum CodingKeys: String, CodingKey {
        case category, title, description, hint, explanation, imageName
    }
    
}

enum Category: String, CaseIterable {
    case military = "Military"
    case horror = "Horror"
    case films = "Films"
    case cartoons = "Cartoons"
    case anime = "Anime"
    case ordinary = "Ordinary"
}
