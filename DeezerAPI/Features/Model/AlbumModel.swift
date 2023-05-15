//
//  AlbumModel.swift
//  DeezerAPI
//
//  Created by ozlem on 14.05.2023.
//

import Foundation

struct AlbumsResponse: Codable {
    let data: [Album]
}

struct Album: Codable {
    let id: Int
    let title: String
    let cover: String
    let coverSmall: String
    let coverMedium: String
    let coverBig: String
    let coverXl: String

    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
    }
}
