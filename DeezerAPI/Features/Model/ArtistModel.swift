//
//  ArtistModel.swift
//  DeezerAPI
//
//  Created by ozlem on 14.05.2023.
//

import Foundation

struct ArtistsResponse: Codable {
    let data: [Artist]
}
struct Artist: Codable {
    let id: Int
    let name: String
    let picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String


    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
    }
}
