//
//  ViewController.swift
//  DeezerAPI
//
//  Created by ozlem on 12.05.2023.
//

import UIKit


protocol DeezerOutput {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}
class CategoryViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var viewModel: CategoryViewModelProtocol = CategoryViewModel()
    private var selectedCategoryID: Int?
    private lazy var results: [Result] = []
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        viewModel.fetchItems()
        viewModel.setDelegate(output: self)
    }

    
    func configure(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        tabBarController?.tabBar.isHidden = false
        title = "Categories"
    }

}

extension CategoryViewController:DeezerOutput {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }

    func saveDatas(values: [Result]) {
        results = values
        collectionView.reloadData()
        
    }
    
    
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return results.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryID = results[indexPath.row].id
        performSegue(withIdentifier: "toArtistVC", sender: nil)
            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toArtistVC" {
               if let destinationVC = segue.destination as? ArtistViewController {
                   destinationVC.categoryID = selectedCategoryID
               }
           }
       }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}
