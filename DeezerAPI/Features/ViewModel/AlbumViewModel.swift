//
//  AlbumViewModel.swift
//  DeezerAPI
//
//  Created by ozlem on 14.05.2023.
//

import Foundation

protocol AlbumViewModelProtocol {
    func fetchArtistAlbums(artistID: Int)
    func changeLoading()
    var albums: [Album] { get set }
    var deezerService: DeezerServiceProtocol { get }
    var albumOutput: AlbumOutput? { get set }

    func setDelegate(output: AlbumOutput)
}

final class AlbumViewModel: AlbumViewModelProtocol {

    var albumOutput: AlbumOutput?
    var albums: [Album] = []
    var deezerService: DeezerServiceProtocol
    private var isLoading = false

    init() {
        deezerService = DeezerService()
    }

    func setDelegate(output: AlbumOutput) {
        albumOutput = output
    }

    func fetchArtistAlbums(artistID: Int) {
        changeLoading()
        deezerService.fetchArtistAlbums(artistID: artistID) { [weak self] response in
            self?.changeLoading()
            if let results = response {
                self?.albums = results
                self?.albumOutput?.saveAlbums(albums: results)
            } else {
                self?.albumOutput?.saveAlbums(albums: [])
            }
        }
    }

    func changeLoading() {
        isLoading = !isLoading
        albumOutput?.changeLoading(isLoad: isLoading)
    }
}
