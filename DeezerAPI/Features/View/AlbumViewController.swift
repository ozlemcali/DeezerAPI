//
//  AlbumViewController.swift
//  DeezerAPI
//
//  Created by ozlem on 14.05.2023.
//

import UIKit
protocol AlbumOutput {
    func changeLoading(isLoad: Bool)
    func saveAlbums(albums: [Album])
}

class AlbumViewController: UIViewController {

        @IBOutlet var collectionView: UICollectionView!
        var albumViewModel: AlbumViewModelProtocol = AlbumViewModel()
        private var albums: [Album] = []
        private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
      private var selectedAlbumID: Int?
        var artistID: Int?

        override func viewDidLoad() {
            super.viewDidLoad()
            configure()
            albumViewModel.setDelegate(output: self)
           fetchAlbums()
        }

        func configure() {
            collectionView.delegate = self
            collectionView.dataSource = self
            tabBarController?.tabBar.isHidden = false
            title = "Albums"
            
        }
    func fetchAlbums() {
            guard let artistID = artistID else {
                return
            }
        albumViewModel.fetchArtistAlbums(artistID: artistID )
        }
    }

    extension AlbumViewController: AlbumOutput {
        func changeLoading(isLoad: Bool) {
            isLoad ? indicator.startAnimating() : indicator.stopAnimating()
        }

        func saveAlbums(albums: [Album]) {
            self.albums = albums
            collectionView.reloadData()
        }
    }

    extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return albums.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumViewCell

            cell.saveModel(model: albums[indexPath.row])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            selectedAlbumID = albums[indexPath.row].id
            performSegue(withIdentifier: "toSongVC", sender: nil)
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toSongVC" {
                if let destinationVC = segue.destination as? SongViewController {
                    destinationVC.albumID = selectedAlbumID
                }
                    
            }
        }
        
       
       
    }
    
extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}
