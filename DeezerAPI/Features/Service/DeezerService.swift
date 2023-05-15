//
//  DeezerService.swift
//  DeezerAPI
//
//  Created by ozlem on 12.05.2023.
//

import Foundation
import Alamofire

enum DeezerServiceEndPoint: String {
    case BASE_URL = "https://api.deezer.com"
    case PATH = "/genre"

    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}


protocol DeezerServiceProtocol {
    func fetchAllDatas(response: @escaping ([Result]?) -> Void)
    func fetchArtistsInCategory(categoryID: Int, response: @escaping ([Artist]?) -> Void)
    func fetchArtistAlbums(artistID: Int, response: @escaping ([Album]?) -> Void)
    func fetchSongsInAlbum(albumID: Int, response: @escaping ([Song]?) -> Void) 
    
}


struct DeezerService: DeezerServiceProtocol {

    func fetchAllDatas(response: @escaping ([Result]?) -> Void) {
        AF.request(DeezerServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self) { (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.data)
        }
    }
    
    
    func fetchArtistsInCategory(categoryID: Int, response: @escaping ([Artist]?) -> Void) {
            let url = "\(DeezerServiceEndPoint.BASE_URL.rawValue)/genre/\(categoryID)/artists"
            AF.request(url).responseDecodable(of: ArtistsResponse.self) { (dataResponse) in
                switch dataResponse.result {
                case .success(let model):
                    response(model.data)
                case .failure(let error):
                    print("Error fetching artists: \(error)")
                    response(nil)
                }
            }
        }
    
    func fetchArtistAlbums(artistID: Int, response: @escaping ([Album]?) -> Void) {
            let url = "https://api.deezer.com/artist/\(artistID)/albums"
            AF.request(url).responseDecodable(of: AlbumsResponse.self) { (dataResponse) in
                switch dataResponse.result {
                case .success(let model):
                    response(model.data)
                case .failure(let error):
                    print("Error fetching artist albums: \(error)")
                    response(nil)
                }
            }
        }
    
    func fetchSongsInAlbum(albumID: Int, response: @escaping ([Song]?) -> Void) {
           let url = "https://api.deezer.com/album/\(albumID)"
           AF.request(url).responseDecodable(of: AlbumResponse.self) { (dataResponse) in
               switch dataResponse.result {
               case .success(let album):
                   response(album.tracks?.data)
               case .failure(let error):
                   print("Error fetching songs: \(error)")
                   response(nil)
               }
           }
       }

}

