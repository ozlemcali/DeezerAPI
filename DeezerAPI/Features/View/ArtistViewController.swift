//
//  ArtistViewController.swift
//  DeezerAPI
//
//  Created by ozlem on 14.05.2023.
//

import UIKit

protocol ArtistOutput {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Artist])
}

class ArtistViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var artistViewModel: ArtistViewModelProtocol = ArtistViewModel()
    private lazy var results: [Artist] = []
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var selectedID: Int?
    var categoryID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        artistViewModel.setDelegate(output: self)
        fetchArtists()
    }
    
    func configure(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        tabBarController?.tabBar.isHidden = false
        title = "Artists"
        
        
    }
    
    func fetchArtists() {
            guard let categoryID = categoryID else {
                return
            }
            artistViewModel.fetchArtistsInCategory(categoryID: categoryID)
        }

}


extension ArtistViewController:ArtistOutput {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }

    func saveDatas(values: [Artist]) {
        results = values
        collectionView.reloadData()
        
    }
}

extension ArtistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artistCell", for: indexPath) as! ArtistViewCell
    
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedID = results[indexPath.row].id
        performSegue(withIdentifier: "toAlbumVC", sender: nil)
            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toAlbumVC" {
               if let destinationVC = segue.destination as? AlbumViewController {
                   destinationVC.artistID = selectedID
               }
           }
       }
    
}
extension ArtistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}
