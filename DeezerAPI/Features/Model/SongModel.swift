//
//  SongModel.swift
//  DeezerAPI
//
//  Created by ozlem on 14.05.2023.
//

import Foundation

struct AlbumResponse: Codable {
    let tracks: TracksData?
}

struct TracksData: Codable {
    let data: [Song]
  
}

struct Song: Codable {
    let id: Int
       let title: String
       let duration: Int
       let album: Album
       let preview: String?

       enum CodingKeys: String, CodingKey {
           case id
           case title
           case duration
           case album
           case preview = "preview"
       }
   }
