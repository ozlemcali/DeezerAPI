//
//  CategoryCell.swift
//  DeezerAPI
//
//  Created by ozlem on 12.05.2023.
//

import UIKit
import AlamofireImage
class CategoryCell: UICollectionViewCell {
    
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var categoryImage: UIImageView!
    private let randomImage: String = "https://picsum.photos/200/300"
    
    func saveModel(model: Result) {
        categoryName.text = model.name
        categoryImage.af.setImage(withURL: URL(string: model.picture ?? randomImage) ?? URL(string: randomImage)!)
    }
}


