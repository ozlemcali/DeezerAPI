//
//  ArtistViewModel.swift
//  DeezerAPI
//
//  Created by ozlem on 14.05.2023.
//

import Foundation

protocol ArtistViewModelProtocol {
    func fetchArtistsInCategory(categoryID: Int)
    func changeLoading()
    var artists: [Artist] { get set }
    var deezerService: DeezerServiceProtocol { get }
    var artistOutput: ArtistOutput? { get set }

    func setDelegate(output: ArtistOutput)
}

final class ArtistViewModel: ArtistViewModelProtocol {

    var artistOutput: ArtistOutput?
    var artists: [Artist] = []
    var deezerService: DeezerServiceProtocol
    private var isLoading = false

    init() {
        deezerService = DeezerService()
    }

    func setDelegate(output: ArtistOutput) {
        artistOutput = output
    }

    func fetchArtistsInCategory(categoryID: Int) {
        changeLoading()
        deezerService.fetchArtistsInCategory(categoryID: categoryID) { response in
            self.changeLoading()
            if let results = response{
                self.artists = results
                self.artistOutput?.saveDatas(values: results)
            }else{
                self.artistOutput?.saveDatas(values: [])
            }
        }
    }

    func changeLoading() {
        isLoading = !isLoading
        artistOutput?.changeLoading(isLoad: isLoading)
    }
}
