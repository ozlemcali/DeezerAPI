//
//  DeezerViewModel.swift
//  DeezerAPI
//
//  Created by ozlem on 12.05.2023.
//

import Foundation


protocol CategoryViewModelProtocol {
    func fetchItems()
    func changeLoading()
    var deezerCategories: [Result] { get set }
    var deezerService: DeezerServiceProtocol { get }
    var deezerOutput: DeezerOutput? { get set }

    func setDelegate(output: DeezerOutput)
}

final class CategoryViewModel: CategoryViewModelProtocol {

    var deezerOutput: DeezerOutput?
    var deezerCategories: [Result] = []
    var deezerService: DeezerServiceProtocol
    private var isLoading = false

    init() {
        deezerService = DeezerService()
    }

    func setDelegate(output: DeezerOutput) {
        deezerOutput = output
    }

    func fetchItems() {
        changeLoading()
        deezerService.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            if let results = response {
                self?.deezerCategories = results
                self?.deezerOutput?.saveDatas(values: results)
            } else {
                self?.deezerOutput?.saveDatas(values: [])
            }
        }
    }

    func changeLoading() {
        isLoading = !isLoading
        deezerOutput?.changeLoading(isLoad: isLoading)
    }
}


