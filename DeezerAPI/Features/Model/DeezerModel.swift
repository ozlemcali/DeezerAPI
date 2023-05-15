//
//  DeezerModel.swift
//  DeezerAPI
//
//  Created by ozlem on 12.05.2023.
//

import Foundation


struct PostModel: Codable {
    let data: [Result]
}

struct Result: Codable {
    let id: Int
    let name: String
    let picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case id, name, picture, type
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
    }
}



