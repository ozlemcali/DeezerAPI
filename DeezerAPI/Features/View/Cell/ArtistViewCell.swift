//
//  ArtistViewCell.swift
//  DeezerAPI
//
//  Created by ozlem on 14.05.2023.
//

import UIKit
import AlamofireImage

class ArtistViewCell: UICollectionViewCell {
    
    @IBOutlet var artistName: UILabel!
    @IBOutlet var artistImage: UIImageView!
    private let randomImage: String = "https://picsum.photos/200/300"
    
    func saveModel(model: Artist) {
        artistName.text = model.name
        artistImage.af.setImage(withURL: URL(string: model.picture ?? randomImage) ?? URL(string: randomImage)!)
    }
}
