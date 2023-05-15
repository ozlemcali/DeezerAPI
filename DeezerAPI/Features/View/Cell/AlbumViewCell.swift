//
//  AlbumViewCell.swift
//  DeezerAPI
//
//  Created by ozlem on 14.05.2023.
//

import UIKit
import AlamofireImage

class AlbumViewCell: UICollectionViewCell {
    
    @IBOutlet var albumName: UILabel!
    @IBOutlet var albumImage: UIImageView!
    
    private let randomImage: String = "https://picsum.photos/200/300"
    
    func saveModel(model: Album) {
        albumName.text = model.title
        albumImage.af.setImage(withURL: URL(string: model.coverMedium ?? randomImage) ?? URL(string: randomImage)!)
    }
}
