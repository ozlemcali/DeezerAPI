//
//  SongViewModel.swift
//  DeezerAPI
//
//  Created by ozlem on 14.05.2023.
//

import Foundation


protocol SongViewModelProtocol {
    func fetchSongsInAlbum(albumID: Int)
    func changeLoading()
    var songs: [Song] { get set }
    var deezerService: DeezerServiceProtocol { get }
    var songOutput: SongOutput? { get set }

    func setDelegate(output: SongOutput)
}

final class SongViewModel: SongViewModelProtocol {

    var songOutput: SongOutput?
    var songs: [Song] = []
    var deezerService: DeezerServiceProtocol
    private var isLoading = false

    init() {
        deezerService = DeezerService()
    }

    func setDelegate(output: SongOutput) {
        songOutput = output
    }

    func fetchSongsInAlbum(albumID: Int) {
        changeLoading()
        deezerService.fetchSongsInAlbum(albumID: albumID) { response in
            self.changeLoading()
            if let results = response {
                self.songs = results
                self.songOutput?.saveSongs(songs: results)
            } else {
                self.songOutput?.saveSongs(songs: [])
            }
        }
    }

    func changeLoading() {
        isLoading = !isLoading
        songOutput?.changeLoading(isLoad: isLoading)
    }
}


